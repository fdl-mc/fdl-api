from typing import Dict
from fastapi import APIRouter, Depends
from fastapi.exceptions import HTTPException
from google.cloud.firestore_v1.base_document import DocumentSnapshot
from google.cloud.firestore_v1.document import DocumentReference
from fdl_api.models.transaction import Transaction
from fdl_api.utils.instances import db
from fdl_api.utils.depedencies import verify_token
from fdl_api.models.transaction_data import TransactionData

router = APIRouter(prefix="/economy")


@router.post("/pay", response_model=Transaction)
async def pay(data: TransactionData, auth: Dict = Depends(verify_token)):
    payer_id = auth["user_id"]

    users = db.collection("users")
    transactions = db.collection("transactions")

    payer_reference: DocumentReference = users.document(payer_id)
    payee_reference: DocumentReference = users.document(data.payee)

    payer_snapshot: DocumentSnapshot = payer_reference.get()
    payee_snapshot: DocumentSnapshot = payee_reference.get()

    payer = payer_snapshot.to_dict()
    payee = payee_snapshot.to_dict()

    if not payee:
        raise HTTPException(404, "User not found")

    if payer["balance"] < data.amount:
        raise HTTPException(403, "Insufficient funds")

    payer_reference.update({"balance": payer["balance"] - data.amount})
    payee_reference.update({"balance": payee["balance"] + data.amount})

    transaction: DocumentSnapshot = transactions.add(
        {
            "payer": payer_id,
            "payee": data.payee,
            "amount": data.amount,
            "system": False,
        }
    )[1].get()

    return transaction.to_dict() | {"id": transaction.id, "at": transaction.create_time}
