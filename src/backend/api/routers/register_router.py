from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from db.database import get_db
from api.services.register_service import register_user_service
from api.models.request_models import RegisterRequest

register_router = APIRouter()

@register_router.post("/register")
def register_user(request: RegisterRequest, db: Session = Depends(get_db)):
    print(request)
    return register_user_service(request, db)
