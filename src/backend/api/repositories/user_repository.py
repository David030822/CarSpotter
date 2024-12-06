from sqlalchemy.orm import Session
from db.tables.models import User,Favourite, OwnCar, Dealer
from api.models.request_models import UserUpdate

def get_user_by_id(db: Session, user_id: int):
    return db.query(User).filter(User.id == user_id).first()

def get_user_by_email(db: Session, email: str):
    return db.query(User).filter(User.email == email).first()

def get_user_by_dealer_id(db: Session, dealer_id: int):
    return db.query(User).filter(User.dealer_id == dealer_id).first()

def create_user(db: Session, user_data: dict):
    new_user = User(**user_data)
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    return new_user

def get_favourite(db: Session, user_id: int, dealer_id: int = None):
    query = db.query(Favourite).filter(Favourite.user_id == user_id)
    if dealer_id:
        query = query.filter(Favourite.dealer_id == dealer_id)
    return query.first() if dealer_id else query.all()

def get_favourite_dealers_by_user(db: Session, user_id: int):
    return (
        db.query(Dealer)
        .join(Favourite, Dealer.id == Favourite.dealer_id)
        .filter(Favourite.user_id == user_id)
        .all()
    )

def add_favourite(db: Session, user_id: int, dealer_id: int):
    new_favourite = Favourite(user_id=user_id, dealer_id=dealer_id)
    db.add(new_favourite)
    db.commit()

def remove_favourite(db: Session, favourite: Favourite):
    db.delete(favourite)
    db.commit()


def get_own_cars_by_user(db: Session, user_id: int):
    return db.query(OwnCar).filter(OwnCar.user_id == user_id).all()


def update_user_repository(existing_user: User, user_data: UserUpdate, db: Session) -> User:
    existing_user.first_name = user_data.first_name
    existing_user.last_name = user_data.last_name
    existing_user.phone = user_data.phone
    existing_user.email = user_data.email

    db.commit()
    db.refresh(existing_user)
    return existing_user
