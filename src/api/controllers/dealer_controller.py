from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from api.services.dealer_service import insert_cars_by_dealer
from db.database import get_db
from db.tables.models import Car, Dealer

router = APIRouter()

@router.post("/dealer/{dealer_name}/sync-cars")
def add_cars(dealer_name: str, db: Session = Depends(get_db)):
    try:
        result = insert_cars_by_dealer(db, dealer_name)
        return result
    except ValueError as e:
        raise HTTPException(status_code=404, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"An error occurred: {str(e)}")


@router.get("/dealer/{dealer_name}/cars")
def get_cars_by_dealer(dealer_name: str, db: Session = Depends(get_db)):
    # Ellenőrizzük, hogy létezik-e a kereskedő
    dealer = db.query(Dealer).filter_by(name=dealer_name).first()
    if not dealer:
        raise HTTPException(status_code=404, detail=f"Dealer '{dealer_name}' not found.")

    cars = db.query(Car).filter_by(dealer_id=dealer.id).all()
    if not cars:
        raise HTTPException(status_code=404, detail=f"No cars found for dealer '{dealer_name}'.")

    return [ 
        {
            "id": car.id,
            "model": car.model,
            "km": car.km,
            "year": car.year,
            "price": car.price,
            "combustible": car.combustible,
            "gearbox": car.gearbox,
            "body_type": car.body_type,
            "cylinder_capacity": car.cylinder_capacity,
            "power": car.power,
            "dateof_post": car.dateof_post,
            "id_post": car.id_post,
            "img_url": car.img_url,
        } for car in cars
    ]