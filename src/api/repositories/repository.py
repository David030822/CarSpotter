from sqlalchemy.orm import Session
from db.tables.models import Car, Dealer, SoldCar
from datetime import datetime

def add_car(db: Session, car_data: dict):
    required_fields = ['model', 'km', 'year', 'price', 'combustible', 'gearbox', 'body_type', 'cylinder_capacity', 'power', 'dateof_post', 'id_post', 'img_url']
    for field in required_fields:
        if field not in car_data:
            raise ValueError(f"Missing required field: {field}")

    try:
        car_data['km'] = float(car_data['km'].replace(" km", "").replace(" ", ""))
        car_data['price'] = float(car_data['price'].replace(" ", "").replace(",", "."))
        car_data['year'] = int(car_data['year'])
        car_data['power'] = int(car_data['power'].replace(" CP", "").replace(" ", ""))
        if car_data.get('cylinder_capacity') is not None:
            car_data['cylinder_capacity'] = int(car_data['cylinder_capacity'].replace(" cm3", "").replace(" ", ""))
        else:
            car_data['cylinder_capacity'] = 0 
        car_data['dateof_post'] = datetime.strptime(car_data['dateof_post'], '%d.%m.%Y').date()
    except ValueError as e:
        raise ValueError(f"Invalid data format: {e}")

    db_car = Car(**car_data)
    db.add(db_car)
    db.commit()
    db.refresh(db_car)
    return db_car


def add_dealer(db: Session, dealer_name: str, inventory_name: str, locality: str, active_since: str, image_url: str):
    existing_dealer = db.query(Dealer).filter_by(inventory_name=inventory_name).first()
    
    if existing_dealer:
        return existing_dealer
    
    new_dealer = Dealer(
        name=dealer_name,
        inventory_name=inventory_name,
        locality=locality,
        active_since=active_since,
        image_url=image_url
    )
    
    db.add(new_dealer)
    db.commit()
    db.refresh(new_dealer) 
    return new_dealer


def add_sold_car(db: Session, car_id: int, sold_price: float):
    existing_car = db.query(SoldCar).filter_by(car_id=car_id).first()
    
    if existing_car:
        return existing_car
    
    new_sold_car = SoldCar(
        car_id=car_id,
        sold_date=datetime.now().date(),
        sold_price=sold_price,
    )
    
    db.add(new_sold_car)
    db.commit()
    db.refresh(new_sold_car) 
    return new_sold_car