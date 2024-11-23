from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from db.database import get_db
from db.tables.models import Favourite, User, Dealer
from sqlalchemy.exc import IntegrityError

user_router = APIRouter()

@user_router.post("/user/{user_id}/favorite/{dealer_id}")
def add_favourite(user_id: int, dealer_id: int, db: Session = Depends(get_db)):
    print("add Favourite")
    try:

        user = db.query(User).filter(User.id == user_id).first()
        print(user.first_name)
        if not user:
            print("nincs user")
            raise HTTPException(status_code=404, detail="User not found")

        dealer = db.query(Dealer).filter(Dealer.id == dealer_id).first()
        print(dealer.name)
        if not dealer:
            print("nincs dealer")
            raise HTTPException(status_code=404, detail="Dealer not found")

        existing_favourite = db.query(Favourite).filter(Favourite.user_id == user_id, Favourite.dealer_id == dealer_id).first()
        if existing_favourite:
            raise HTTPException(status_code=400, detail="Dealer is already in your favorites")

        new_favorite = Favourite(user_id=user_id, dealer_id=dealer_id)
        db.add(new_favorite)
        db.commit()

        return {"message": "Dealer added to favorites"}

    except IntegrityError:
        db.rollback()
        raise HTTPException(status_code=400, detail="Error adding favorite")
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=f"An error occurred: {str(e)}")


@user_router.get("/user/{user_id}/favorites")
def get_favourites(user_id: int, db: Session = Depends(get_db)):
    try:
        user = db.query(User).filter(User.id == user_id).first()
        if not user:
            raise HTTPException(status_code=404, detail="User not found")

        favourites = db.query(Dealer).join(Favourite).filter(Favourite.user_id == user_id).all()

        if not favourites:
            return {"message": "No favorite dealers found for this user."}

        return {"favorites": favourites}

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"An error occurred: {str(e)}")

@user_router.delete("/user/{user_id}/favorite/{dealer_id}")
def remove_favourite(user_id: int, dealer_id: int, db: Session = Depends(get_db)):
    try:
        # Ellenőrizzük, hogy létezik-e a felhasználó
        user = db.query(User).filter(User.id == user_id).first()
        if not user:
            raise HTTPException(status_code=404, detail="User not found")

        # Ellenőrizzük, hogy létezik-e a kereskedő
        dealer = db.query(Dealer).filter(Dealer.id == dealer_id).first()
        if not dealer:
            raise HTTPException(status_code=404, detail="Dealer not found")

        # Ellenőrizzük, hogy a kedvenc már létezik
        existing_favourite = db.query(Favourite).filter(Favourite.user_id == user_id, Favourite.dealer_id == dealer_id).first()
        if not existing_favourite:
            raise HTTPException(status_code=400, detail="Dealer is not in your favorites")

        # Kedvenc eltávolítása
        db.delete(existing_favourite)
        db.commit()

        return {"message": "Dealer removed from favorites"}

    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=f"An error occurred: {str(e)}")
