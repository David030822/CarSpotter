from fastapi import APIRouter, Depends, File, HTTPException, UploadFile
from sqlalchemy.orm import Session
from db.database import get_db
from api.services.user_service import (
    add_favourite_service,
    get_favourites_service,
    remove_favourite_service,
    get_own_cars_service,
    get_user_data_service,
    update_user_data_service,
    update_user_image_service
)
from api.models.response_models import CarResponse, UserDataResponse, List
from api.models.request_models import UserUpdate
from api.repositories.save_file import save_file

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


@user_router.put("/user/{user_id}", response_model=UserUpdate)
def update_user_data(user_id: int, user_data: UserUpdate, db: Session = Depends(get_db)):
    updated_user = update_user_data_service(user_id, user_data, db)
    if not updated_user:
        raise HTTPException(status_code=404, detail="User not found")
    return updated_user


@user_router.put("/user-image/{user_id}")
async def update_user_image(
    user_id: int,
    profile_image: UploadFile = File(None), 
    db: Session = Depends(get_db),
):
    if profile_image:
        profile_image_path = save_file(profile_image)  
    else:
        profile_image_path = None

    updated_user = update_user_image_service(user_id, profile_image_path, db)
    if not updated_user:
        raise HTTPException(status_code=404, detail="User not found")
    return updated_user
