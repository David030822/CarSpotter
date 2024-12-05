from pydantic import BaseModel, EmailStr

class LoginRequest(BaseModel):
    email: EmailStr
    password: str

class UserUpdate(BaseModel):
    first_name: str
    last_name: str
    phone: str
    email: str

    class Config:
        orm_mode = True 
