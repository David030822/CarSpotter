from sqlalchemy import Column, Integer, String,Boolean
from .database import Base

class User(Base):
    _tablename_="user"
    id=Column(Integer,primary_key=True,index=True)
    first_name=Column(String(50), nullable=False)
    last_name=Column(String(100),nullable=False)
    is_dealer=Column(Boolean, nullable=False)
    password=Column(String(255),nullable=False)
    email=Column(String(255),nullable=False)
    phone=Column(Integer(20),nullable=False)
    profile_url=Column(String(255),nullable=True)
