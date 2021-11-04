from pydantic import BaseModel
from datetime import datetime
from typing import Optional


class Transaction(BaseModel):
    id: str
    payer: str
    payee: str
    amount: int
    at: datetime
    comment: Optional[str]
    system: bool
