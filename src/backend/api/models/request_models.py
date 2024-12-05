from pydantic import BaseModel, EmailStr
from fastapi import File, UploadFile, Form
from typing import Optional, Annotated

class LoginRequest(BaseModel):
    email: EmailStr
    password: str
