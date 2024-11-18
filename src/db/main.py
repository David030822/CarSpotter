from fastapi import FastApi, HTTPException, Depends
from sqlalchemy.orm import Session
from . import crud,models,database

app = FastApi()

def get_db():
    db = database.SessionLocal()
    try:
        yield db
    finally:
        db.close()

@app.post("/login")
def login(email:str, password:str, db: Session = Depends(get_db)):
    user = crud.login(db,email,password)
    if user is None:
        raise HTTPException(status_code=401,detail="Invalid user")
    return {"message:":"Login successful", "user_id": user.id}

@app.post("/register")
def register(first_name: str, last_name:str, email: str, password: str, phone:int, db: Session = Depends(get_db)):
    user = crud.create_user(db,first_name,last_name,email,password,phone)
    return {"message": "User created successfully", "user_id": user.id}
