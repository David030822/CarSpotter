from fastapi import APIRouter, Depends, HTTPException
from pydantic import BaseModel, EmailStr
from sqlalchemy.orm import Session
from db.database import get_db
from passlib.context import CryptContext
from db.tables.models import User


register_router = APIRouter()

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

class RegisterRequest(BaseModel):
    first_name: str
    last_name: str
    email: EmailStr
    phone: int
    password: str
    profile_url: str = "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"

def hash_password(password: str) -> str:
    return pwd_context.hash(password)

@register_router.post("/register")
def register_user(request: RegisterRequest, db: Session = Depends(get_db)):
    try:
        existing_user = db.query(User).filter(User.email == request.email).first()
        if existing_user:
            raise HTTPException(status_code=400, detail="Email already registered.")
        
        new_user = User(
            first_name=request.first_name,
            last_name=request.last_name,
            email=request.email,
            phone=request.phone,
            password=hash_password(request.password),
            profile_url=request.profile_url,
        )
        db.add(new_user)
        db.commit()
        db.refresh(new_user)
        return {"message": "User registered successfully", "user_id": new_user.id}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"An error occurred: {e}")

