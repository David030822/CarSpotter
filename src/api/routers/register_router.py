from fastapi import APIRouter, Depends, HTTPException
from pydantic import BaseModel, EmailStr
from sqlalchemy.orm import Session
from db.database import get_db
from passlib.context import CryptContext
from db.tables.models import User, Dealer, Car, OwnCar
from api.services.service import insert_cars_and_dealer_by_dealer_name


register_router = APIRouter()

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

class RegisterRequest(BaseModel):
    first_name: str
    last_name: str
    email: EmailStr
    phone: int
    password: str
    profile_url: str = "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"
    dealer_inventory_name: str = ""

def hash_password(password: str) -> str:
    return pwd_context.hash(password)

@register_router.post("/register")
def register_user(request: RegisterRequest, db: Session = Depends(get_db)):
    try:
        existing_user = db.query(User).filter(User.email == request.email).first()
        if existing_user:
            raise HTTPException(status_code=400, detail="Email already registered.")
        
        new_user_data = {
            "first_name": request.first_name,
            "last_name": request.last_name,
            "email": request.email,
            "phone": request.phone,
            "password": hash_password(request.password),
            "profile_url": request.profile_url
        }
        
        if request.dealer_inventory_name and request.dealer_inventory_name.strip():
            dealer = db.query(Dealer).filter(Dealer.inventory_name == request.dealer_inventory_name).first()
            if not dealer:
                insert_cars_and_dealer_by_dealer_name(db, request.dealer_inventory_name)
                dealer = db.query(Dealer).filter(Dealer.inventory_name == request.dealer_inventory_name).first()
                if not dealer:
                    raise HTTPException(status_code=400, detail="Not a valid dealer.")
                
            user = db.query(User).filter(User.dealer_id == dealer.id).first()
            if user:
                raise HTTPException(status_code=400, detail="Dealer name is already used by another user")
            new_user_data["dealer_id"] = dealer.id

            new_user = User(**new_user_data)
            db.add(new_user)
            db.commit() 
            db.refresh(new_user)

            cars = db.query(Car).filter(Car.dealer_id == dealer.id)
            for car in cars:
                own_car = OwnCar(
                    user_id=new_user.id, 
                    model=car.model,
                    km=car.km,
                    year=car.year,
                    price=car.price,
                    combustible=car.combustible,
                    gearbox=car.gearbox,
                    body_type=car.body_type,
                    cylinder_capacity=car.cylinder_capacity,
                    power=car.power,
                    dateof_post=car.dateof_post,
                    img_url=car.img_url
                )
                db.add(own_car)
        else:
            new_user = User(**new_user_data)
            db.add(new_user)
            db.commit()
            db.refresh(new_user)

        db.commit()
        return {"message": "User registered successfully", "user_id": new_user.id}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"An error occurred: {e}")

