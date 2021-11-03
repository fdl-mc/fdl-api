from datetime import date
from pydantic import BaseModel


class User(BaseModel):
    id: str
    nickname: str
    discord_id: str
    balance: int
    flags: int
    created_at: date
