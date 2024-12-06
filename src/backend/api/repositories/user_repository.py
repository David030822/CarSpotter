from sqlalchemy.orm import Session
from db.tables.models import Followers, User,Favourite, OwnCar, Dealer
from api.models.request_models import UserUpdate,NewOwnCarRequest
from datetime import datetime

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


def add_car_to_db(db: Session, user_id: int, car_data: NewOwnCarRequest) -> OwnCar:
    new_car = OwnCar(
        model=car_data.model,
        km=car_data.km,
        year=car_data.year,
        combustible=car_data.combustible,
        gearbox=car_data.gearbox,
        body_type=car_data.body_type,
        engine_size=car_data.engine_size,
        power=car_data.power,
        selling_for=car_data.selling_for,
        bought_for=car_data.bought_for,
        spent_on=car_data.spent_on,
        sold_for=car_data.sold_for,
        purchase_date=datetime.now().date(),
        img_url=car_data.img_url,
        user_id=user_id
    )
    db.add(new_car)
    db.commit()
    db.refresh(new_car) 
    return new_car

def add_following(user_id: int, followed_id: int, db: Session) -> Followers:
    following = Followers(
        follower_id=user_id,
        following_id=followed_id,
        date=datetime.now().date()
    )
    db.add(following)
    db.commit()
    db.refresh(following)
    return following


def is_followed(user_id: int, followed_id: int, db: Session) -> bool:
    result = db.query(Followers).filter(Followers.follower_id == user_id, Followers.following_id == followed_id).first()
    if result:
        return True
    return False