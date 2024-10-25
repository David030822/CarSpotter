import requests
from bs4 import BeautifulSoup

# URL of the Autovit.ro search page
base_url = 'https://www.autovit.ro/autoturisme'

# Adding User-Agent to the request (to mimic a browser)
headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36'
}

# A list to store car data
car_data = []

# Paging
page = 1
max_pages = 1

while True:
    # Request the content of the webpage
    url = f'{base_url}?page={page}'
    response = requests.get(url, headers=headers)

    # Check if the request was successful (status code 200)
    if response.status_code == 200:
        # Parse the HTML content
        soup = BeautifulSoup(response.text, 'html.parser')

        # Search for car listings
        car_listings = soup.find_all('article', class_='ooa-yca59n efpuxbr0')

        if not car_listings:
            print(f"No more cars found on page {page}.")
            break

        for car in car_listings:
            car_model_element = car.find('h1', class_='efpuxbr9 ooa-1ed90th er34gjf0')
            car_model = car_model_element.text.strip()  # Car model name
            price = car.find('h3', class_='efpuxbr16 ooa-1n2paoq er34gjf0').text  # Car price
            manufacturing_year = car.find('dd', {'data-parameter': 'year'}).text.strip()  # Manufacturing year
            car_link = car_model_element.find('a')['href']  # Link to the car details page

            # Request the detailed page for each car
            car_response = requests.get(car_link, headers=headers)

            if car_response.status_code == 200:
                car_soup = BeautifulSoup(car_response.text, 'html.parser')

                # Extract detailed car data
                dealer = car_soup.find('p', class_='ern8z622 ooa-hlpbot er34gjf0').text.strip()
                details = car_soup.find_all('div', class_='ooa-195ahus e1ho6mkz1')
                mileage = details[0].find_all('p')[1].text.strip()  # Mileage
                fuel_type = details[1].find_all('p')[1].text.strip()  # Fuel type
                gearbox = details[2].find_all('p')[1].text.strip()  # Gearbox type
                body_type = details[3].find_all('p')[1].text.strip()  # Body type
                if len(details) == 6:
                    engine_capacity = details[4].find_all('p')[1].text.strip()
                    power = details[5].find_all('p')[1].text.strip()
                else:
                    engine_capacity = None
                    power = details[4].find_all('p')[1].text.strip()


                # Store the car data in a dictionary
                car_info = {
                    'dealer': dealer,
                    'car_model': car_model,
                    'manufacturing_year': manufacturing_year,
                    'mileage': mileage,
                    'fuel_type': fuel_type,
                    'gearbox': gearbox,
                    'body_type': body_type,
                    'engine_capacity': engine_capacity,
                    'power': power,
                    'price': price
                }

                # car_info = {
                #     'dealer': dealer,
                #     'model_auto': model_auto,
                #     'an_fabricatie': an_fabricatie,
                #     'km': km,
                #     'combustibil': combustibil,
                #     'cutie_de_viteza': cutie_de_viteza,
                #     'tip_caroserie': tip_caroserie,
                #     'capacitate_cilindrica': capacitate_cilindrica,
                #     'putere': putere,
                #     'pret': pret
                # }

                # Add car data to the list
                car_data.append(car_info)

        # Következő oldalra lépés
        page += 1

        # Ha elértük a maximális oldal számot, akkor kilépünk
        if max_pages and page > max_pages:
            print(f"Reached max page limit: {max_pages}")
            break

    else:
        print(f"Error accessing page {page}: {response.status_code}")
        break


for i, car in enumerate(car_data, start=1):
    print(f"{i}. Car: {car['car_model']}, Price: {car['price']}, Dealer: {car['dealer']}, "
          f"Manufacturing Year: {car['manufacturing_year']}, Mileage: {car['mileage']}, "
          f"Fuel Type: {car['fuel_type']}, Gearbox: {car['gearbox']}, "
          f"Body Type: {car['body_type']}, Engine Capacity: {car['engine_capacity']}, "
          f"Power: {car['power']}")

