from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from api.services.dealer_service import insert_cars_by_dealer
from db.database import get_db

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
