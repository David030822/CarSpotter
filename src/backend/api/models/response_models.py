from pydantic import BaseModel
from datetime import date
from typing import List

class CarResponse(BaseModel):
    model: str
    km: int
    year: int
    price: float
    combustible: str
    gearbox: str
    body_type: str
    cylinder_capacity: int
    power: int
    dateof_post: date
    img_url: str

    class Config:
        orm_mode = True

class UserDataResponse(BaseModel):
    first_name: str
    last_name: str
    email: str
    phone: str
    profile_url: str
