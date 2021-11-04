from pydantic import BaseModel
from typing import Optional


class TransactionData(BaseModel):
    payee: str
    amount: int
    comment: Optional[str]
