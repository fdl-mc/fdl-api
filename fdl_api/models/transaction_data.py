from pydantic import BaseModel


class TransactionData(BaseModel):
    payee: str
    amount: int
