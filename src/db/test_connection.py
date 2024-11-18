from sqlalchemy import create_engine

DATABASE_URL= "mysql+pymysql://root:@localhost/carsproject"

try:
    engine = create_engine(DATABASE_URL)
    connection = engine.connect()
    print("Succesfull database connection")
    connection.close()
except Exception as e:
    print("Error in the database connection: {e}")