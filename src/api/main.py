from fastapi import FastAPI
from api.routers.dealer_router import dealer_router
from api.routers.register_router import register_router
from api.routers.login_router import login_router
from api.routers.user_router import user_router
from db.database import init_db, engine
from contextlib import asynccontextmanager

@asynccontextmanager
async def app_lifespan(app: FastAPI):
    init_db()
    print("App is starting up!")
    yield
    engine.dispose()
    print("App is shutting down!")

app = FastAPI(lifespan=app_lifespan)

app.include_router(dealer_router)
app.include_router(register_router)
app.include_router(login_router)
app.include_router(user_router)

@app.get("/")
def root():
    return {"message": "Welcome to the API"}
