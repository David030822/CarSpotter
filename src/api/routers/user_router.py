from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from db.database import get_db
from db.tables.models import Favourite, User, Dealer, Car, OwnCar
from sqlalchemy.exc import IntegrityError
from datetime import datetime

user_router = APIRouter()

@user_router.post("/user/{user_id}/favorite/{dealer_id}")
def add_favourite(user_id: int, dealer_id: int, db: Session = Depends(get_db)):
    print("add Favourite")
    try:

        user = db.query(User).filter(User.id == user_id).first()
        print(user.first_name)
        if not user:
            print("nincs user")
            raise HTTPException(status_code=404, detail="User not found")

        dealer = db.query(Dealer).filter(Dealer.id == dealer_id).first()
        print(dealer.name)
        if not dealer:
            print("nincs dealer")
            raise HTTPException(status_code=404, detail="Dealer not found")

        existing_favourite = db.query(Favourite).filter(Favourite.user_id == user_id, Favourite.dealer_id == dealer_id).first()
        if existing_favourite:
            raise HTTPException(status_code=400, detail="Dealer is already in your favorites")

        new_favorite = Favourite(user_id=user_id, dealer_id=dealer_id)
        db.add(new_favorite)
        db.commit()

        return {"message": "Dealer added to favorites"}

    except IntegrityError:
        db.rollback()
        raise HTTPException(status_code=400, detail="Error adding favorite")
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=f"An error occurred: {str(e)}")


@user_router.get("/user/{user_id}/favorites")
def get_favourites(user_id: int, db: Session = Depends(get_db)):
    try:
        user = db.query(User).filter(User.id == user_id).first()
        if not user:
            raise HTTPException(status_code=404, detail="User not found")

        favourites = db.query(Dealer).join(Favourite).filter(Favourite.user_id == user_id).all()

        if not favourites:
            return {"message": "No favorite dealers found for this user."}

        return {"favorites": favourites}

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"An error occurred: {str(e)}")

@user_router.delete("/user/{user_id}/favorite/{dealer_id}")
def remove_favourite(user_id: int, dealer_id: int, db: Session = Depends(get_db)):
    try:
        user = db.query(User).filter(User.id == user_id).first()
        if not user:
            raise HTTPException(status_code=404, detail="User not found")
        dealer = db.query(Dealer).filter(Dealer.id == dealer_id).first()
        if not dealer:
            raise HTTPException(status_code=404, detail="Dealer not found")
        existing_favourite = db.query(Favourite).filter(Favourite.user_id == user_id, Favourite.dealer_id == dealer_id).first()
        if not existing_favourite:
            raise HTTPException(status_code=400, detail="Dealer is not in your favorites")
        db.delete(existing_favourite)
        db.commit()

        return {"message": "Dealer removed from favorites"}

    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=f"An error occurred: {str(e)}")
    


@user_router.post("/user/{user_id}/owncar/{car_id}")
def add_own_car(user_id: int, car_id: int, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.id == user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    
    if not user.dealer_id:
        raise HTTPException(status_code=404, detail="User is not a dealer")

    car = db.query(Car).filter(Car.id == car_id).first()
    if not car:
        raise HTTPException(status_code=404, detail="Car not found")

    own_car = OwnCar(
        user_id=user_id,
        car_id=car_id,
        purchase_date=car.dateof_post,
        purchase_price=car.price 
    )
    db.add(own_car)
    db.commit()
    db.refresh(own_car)

    return {"message": "Car added to user successfully", "own_car_id": own_car.id}

from pydantic import BaseModel

class CarCreate(BaseModel):
    user_id: int
    model: str
    km: float
    year: int
    price: float
    combustible: str
    gearbox: str
    body_type: str
    cylinder_capacity: int
    power: int
    img_url: str

@user_router.post("/car/")
def add_car(car: CarCreate, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.id == car.user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    
    if not user.dealer_id:
        raise HTTPException(status_code=404, detail="User not a Dealer")
    
    new_car = Car(
        model=car.model,
        km=car.km,
        year=car.year,
        price=car.price,
        combustible=car.combustible,
        gearbox=car.gearbox,
        body_type=car.body_type,
        cylinder_capacity=car.cylinder_capacity,
        power=car.power,
        dateof_post=datetime.now().date(),
        id_post=0,
        dealer_id=user.dealer_id,
        img_url=car.img_url
    )
    db.add(new_car)
    db.commit()
    db.refresh(new_car)

    return {"message": "Car added successfully", "car_id": new_car.id}
