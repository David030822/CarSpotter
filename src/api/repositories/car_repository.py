from sqlalchemy.orm import Session
from db.tables.models import Car, Dealer
from datetime import datetime

def create_car(db: Session, car_data: dict):
    required_fields = ['model', 'km', 'year', 'price', 'combustible', 'gearbox', 'body_type', 'cylinder_capacity', 'power', 'dateof_post', 'id_post', 'img_url']
    for field in required_fields:
        if field not in car_data:
            raise ValueError(f"Missing required field: {field}")

    try:
        car_data['km'] = float(car_data['km'].replace(" km", "").replace(" ", ""))
        car_data['price'] = float(car_data['price'].replace(" ", "").replace(",", "."))
        car_data['year'] = int(car_data['year'])
        car_data['power'] = int(car_data['power'].replace(" CP", "").replace(" ", ""))
        car_data['cylinder_capacity'] = int(car_data['cylinder_capacity'].replace(" cm3", "").replace(" ", ""))
        car_data['dateof_post'] = datetime.strptime(car_data['dateof_post'], '%d.%m.%Y').date()
    except ValueError as e:
        raise ValueError(f"Invalid data format: {e}")

    car_data.pop('dealer', None)
    db_car = Car(**car_data)
    db.add(db_car)
    db.commit()
    db.refresh(db_car)
    return db_car


def add_dealer(db: Session, dealer_name: str):
    existing_dealer = db.query(Dealer).filter_by(name=dealer_name).first()
    if existing_dealer:
        # print("dealer is already exists", existing_dealer.id, existing_dealer.name)
        return existing_dealer
    
    new_dealer = Dealer(name=dealer_name)
    db.add(new_dealer)
    db.commit()
    db.refresh(new_dealer)
    # print("dealer inserted")
    return new_dealer
