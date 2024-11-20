from fastapi import FastAPI
from api.controllers.dealer_controller import router 

app = FastAPI()

# Regisztráljuk a routert
app.include_router(router)

@app.get("/")
def root():
    return {"message": "Welcome to the Dealer API"}
