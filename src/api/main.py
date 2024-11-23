from fastapi import FastAPI
from api.routers.dealer_router import dealer_router

app = FastAPI()

app.include_router(dealer_router)

@app.get("/")
def root():
    return {"message": "Welcome to the Dealer API"}
