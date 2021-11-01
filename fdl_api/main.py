from fastapi import FastAPI
from fdl_api.routes import stats, users

app = FastAPI()

app.include_router(stats.router)
app.include_router(users.router)
