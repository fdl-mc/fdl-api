from shared.instances import db
from secrets import token_urlsafe


def generate_token():
    return token_urlsafe(32)


def get_user_by_token(token: str):
    query = db.collection('users').where('token', '==', token).get()

    if len(query) == 0:
        return None

    return query[0].to_dict()
