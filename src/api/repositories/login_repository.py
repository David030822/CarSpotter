from sqlalchemy.orm import Session
from werkzeug.security import chech_password_hash, generate_password_hash
from db.tables.models import User

def login(db: Session, email: str, password: str):
    user= db.query(user).filter(user.email == email).first() #select the user by email

    if user and chech_password_hash(user.password,password):
        return user
    return None


def create_user(db:Session, first_name: str, last_name: str, email : str, password: str,phone: int):
    hashed_password = generate_password_hash(password)
    new_user = User(
        first_name = first_name,
        last_name= last_name,
        email = email,
        password=hashed_password,
        phone = phone,
    )
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    return new_user