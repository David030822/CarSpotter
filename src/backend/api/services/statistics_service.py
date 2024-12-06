from sqlalchemy.orm import Session
from db.tables.models import Car, Dealer, SoldCar

def calculate_sold_price_and_time_avereage(db: Session, dealer_name: str):
    dealer = db.query(Dealer).filter_by(name=dealer_name).first()
    if not dealer:
        raise ValueError(f"Dealer not found: '{dealer_name}'.")
    
    cars = (
        db.query(Car, SoldCar)
        .join(SoldCar, Car.id == SoldCar.car_id)
        .filter(Car.dealer_id == dealer.id)
        .all()
    )
    if not cars:
        return {"average_price": None, "average_sold_time": None, "number_of_solds": 0}
    
    total_price = 0
    number_of_solds = 0
    sold_time = 0
    for car, sold_car in cars:
        number_of_solds += 1
        total_price += sold_car.sold_price
        sold_time += (sold_car.sold_date - car.dateof_post).days
    
    average_price = total_price / number_of_solds if number_of_solds > 0 else 0
    average_sold_time = int(sold_time / number_of_solds)if number_of_solds > 0 else 0

    return {
        "average_price": average_price,
        "average_sold_time": average_sold_time,
        "number_of_solds": number_of_solds,
    }

