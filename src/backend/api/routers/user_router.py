from fastapi import APIRouter, Depends
from fastapi.responses import FileResponse
from sqlalchemy.orm import Session
from db.database import get_db
from api.services.user_service import (
    add_favourite_service,
    get_favourites_service,
    remove_favourite_service,
    get_own_cars_service,
    get_user_data_service,
)
from api.models.response_models import CarResponse, UserDataResponse, List

user_router = APIRouter()

@user_router.post("/user/{user_id}/favorite/{dealer_id}")
def add_favourite(user_id: int, dealer_id: int, db: Session = Depends(get_db)):
    return add_favourite_service(user_id, dealer_id, db)

@user_router.get("/user/{user_id}/favorites")
def get_favourites(user_id: int, db: Session = Depends(get_db)):
    return get_favourites_service(user_id, db)

@user_router.delete("/user/{user_id}/favorite/{dealer_id}")
def remove_favourite(user_id: int, dealer_id: int, db: Session = Depends(get_db)):
    return remove_favourite_service(user_id, dealer_id, db)

@user_router.get("/user/{user_id}/owncars", response_model=List[CarResponse])
def get_own_cars(user_id: int, db: Session = Depends(get_db)):
    return get_own_cars_service(user_id, db)

@user_router.get("/user/{user_id}", response_model=UserDataResponse)
def get_user_data(user_id: int, db: Session = Depends(get_db)):
    user = get_user_data_service(user_id, db)  

    return UserDataResponse.from_user(user)

