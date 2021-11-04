from typing import Dict
from firebase_admin import auth
from fastapi import Header, HTTPException


async def verify_token(authorization: str = Header(None)) -> Dict:
    try:
        return auth.verify_id_token(authorization, check_revoked=True)
    except:
        raise HTTPException(403, detail="Auth failed")
