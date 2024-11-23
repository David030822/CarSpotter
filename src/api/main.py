from fastapi import FastAPI
from api.routers.dealer_router import dealer_router
from api.routers.register_router import register_router
from api.routers.login_router import login_router
from api.routers.user_router import user_router

app = FastAPI()

app.include_router(dealer_router)
app.include_router(register_router)
app.include_router(login_router)
app.include_router(user_router)

@app.get("/")
def root():
    return {"message": "Welcome to the API"}
