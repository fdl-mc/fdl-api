from fastapi import APIRouter, HTTPException
from fdl_api.models.user import User
from fdl_api.utils.instances import db
from google.cloud.firestore import DocumentSnapshot
from typing import List, Optional

router = APIRouter(prefix="/users", tags=["users"])


@router.get("/find", response_model=List[User])
async def find_users(discord_id: Optional[str] = None, nickname: Optional[str] = None):
    users = []

    if discord_id:
        for user in db.collection("users").stream():
            if user.get("discord_id").lower().startswith(discord_id):
                users.append(
                    user.to_dict() | {"id": user.id, "created_at": user.create_time}
                )
    elif nickname:
        for user in db.collection("users").stream():
            if user.get("nickname").lower().startswith(nickname.lower()):
                users.append(
                    user.to_dict() | {"id": user.id, "created_at": user.create_time}
                )

    return users


@router.get("/{id}", response_model=User)
async def get_user(id: str):
    user = db.collection("users").document(id).get()
    if not user.to_dict():
        raise HTTPException(404, detail="User not found")
    return user.to_dict() | {"id": user.id, "created_at": user.create_time}
