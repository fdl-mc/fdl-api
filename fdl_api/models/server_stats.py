from pydantic import BaseModel


class Players(BaseModel):
    online: int
    max: int
    list: list[str]


class ServerStats(BaseModel):
    ip: str
    port: int
    description: str
    version: str
    latency: int
    players: Players
