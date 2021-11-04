from pydantic import BaseModel
from datetime import datetime


class Transaction(BaseModel):
    id: str
    payer: str
    payee: str
    amount: int
    at: datetime
    system: bool
