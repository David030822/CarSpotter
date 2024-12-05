from fastapi import HTTPException
from sqlalchemy.orm import Session
from api.models.request_models import UserUpdate
from api.repositories.dealer_car_repository import get_dealer_by_id
from api.repositories.user_repository import (
    get_favourite,
    add_favourite,
    remove_favourite,
    get_user_by_id,
    get_own_cars_by_user,
    get_favourite_dealers_by_user,
    update_user_repository
)

def add_favourite_service(user_id: int, dealer_id: int, db: Session):
    user = get_user_by_id(db, user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    dealer = get_dealer_by_id(db, dealer_id)
    if not dealer:
        raise HTTPException(status_code=404, detail="Dealer not found")
    if get_favourite(db, user_id, dealer_id):
        raise HTTPException(status_code=400, detail="Dealer is already in your favorites")
    
    add_favourite(db, user_id, dealer_id)
    return {"message": "Dealer added to favorites"}

def get_favourites_service(user_id: int, db: Session):
    user = get_user_by_id(db, user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    favourite_dealers = get_favourite_dealers_by_user(db, user_id)
    if not favourite_dealers:
        return {"message": "No favorite dealers found for this user."}

    return {"favorites": favourite_dealers}

def remove_favourite_service(user_id: int, dealer_id: int, db: Session):
    user = get_user_by_id(db, user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    dealer = get_dealer_by_id(db, dealer_id)
    if not dealer:
        raise HTTPException(status_code=404, detail="Dealer not found")
    
    favourite = get_favourite(db, user_id, dealer_id)
    if not favourite:
        raise HTTPException(status_code=400, detail="Dealer is not in your favorites")
    
    remove_favourite(db, favourite)
    return {"message": "Dealer removed from favorites"}

def get_own_cars_service(user_id: int, db: Session):
    user = get_user_by_id(db, user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    if not user.dealer_id:
        raise HTTPException(status_code=400, detail="User is not a dealer")
    
    return get_own_cars_by_user(db, user_id)

def get_user_data_service(user_id: int, db: Session):
    user = get_user_by_id(db, user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    
    return user


def update_user_data_service(user_id: int, user_data: UserUpdate, db: Session):
    existing_user = get_user_by_id(db,user_id)
    
    if not existing_user:
        raise HTTPException(status_code=404, detail="User not found")
    
    updated_user = update_user_repository(existing_user, user_data, db)
    
    return updated_user