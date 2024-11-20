from db.database import get_db
from api.services.dealer_service import insert_cars_by_dealer
from api.controllers.dealer_controller import get_cars_by_dealer

def main():
 
    db = next(get_db())
    
    #dealer_name = "Royal AutomobileMures"
    dealer_name = "david bys cars"
    
    print(f"Processing dealer: {dealer_name}")
    result = insert_cars_by_dealer(db, dealer_name)
    #result = get_cars_by_dealer(dealer_name, db)
    print(result)

if __name__ == "__main__":
    main()