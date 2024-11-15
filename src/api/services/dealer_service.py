from sqlalchemy.orm import Session
from ..repositories.car_repository import create_car, add_dealer
from scraper.scripts import scrape_dealer_inventory 
from db.tables.models import Car  

def insert_cars_by_dealer(db: Session, dealer_name: str):

    scraped_data = scrape_dealer_inventory.scrape_dealer_inventory(dealer_name)
    
    if not scraped_data:
        raise ValueError("No data retrieved from scraping.")
    
    added_cars = 0  

    one_car = scraped_data[0]
    dealer_correct_name = one_car['dealer']

    dealer = add_dealer(db, dealer_correct_name)
   
    for car_data in scraped_data:
        car_data['dealer_id'] = dealer.id

        existing_car = db.query(Car).filter_by(id_post=car_data['id_post']).first()
        if existing_car:
            print(f"Car with id_post={car_data['id_post']} already exists. Skipping.")
            continue

        create_car(db, car_data)
        added_cars += 1

    return {
        "message": f"Dealer and associated cars processed.",
        "cars_added": added_cars,
        "total_scraped": len(scraped_data),
    }
