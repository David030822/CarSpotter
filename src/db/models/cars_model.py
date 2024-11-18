from sqlalchemy import Column,Integer,String,Double
from ..database import Base

class Cars(Base):
    _tablename_="cars"
    id=Column(Integer,primary_key=True, index=True)
    model=Column(String(255),nullable=False)
    description=Column(String(255),nullable=False)
    km=Column(Double,nullable=False)
    

