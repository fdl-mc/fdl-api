from shared.instances import db
from secrets import token_urlsafe


def get_token_from_request(request):
    if request.headers.has_key('Authorization'):
        return request.headers['Authorization']
    return None


def generate_token():
    return token_urlsafe(32)


def get_user_by_token(token: str):
    query = db.collection('users').where('token', '==', token).get()

    if len(query) == 0:
        return None

    return query[0]
