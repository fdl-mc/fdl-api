from pydantic import BaseSettings


class Settings(BaseSettings):
    fba_credentials: dict
