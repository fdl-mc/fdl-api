from flask import Blueprint, request
from shared.instances import db
from utils.auth_utils import get_user_by_token, get_token_from_request

economy_bp = Blueprint('economy', __name__)


@economy_bp.route('/pay')
def pay():
    try:
        args = request.args.to_dict()

        token = get_token_from_request(request)
        if token is None:
            return {'message': 'Пустой токен.'}, 401

        for val in ['payee', 'amount']:
            if val not in args:
                return {'message': f'Необходим параметр {val}.'}, 400

        payee = args['payee']
        amount = int(args['amount'])

        payer_doc = get_user_by_token(token)
        if payer_doc is None:
            return {'message': 'Неудачная авторизация.'}, 401

        payer_balance = payer_doc.to_dict()['balance']

        if payer_balance < amount:
            return {'message': 'Недостаточно средств.'}, 403

        query = db.collection('users').where('name', '==', payee).get()

        if (len(query) == 0):
            return {'message': 'Пользователь не найден.'}, 404

        payee_doc = query[0]
        payee_balance = payee_doc.to_dict()['balance']

        payer_doc.reference.update({'balance': payer_balance - amount})
        payee_doc.reference.update({'balance': payee_balance + amount})

        return {'message': f'Успешно переведено ${amount} ИБ пользователю ${payee}.'}, 200

    except Exception as e:
        return {'message': f'Внутренняя ошибка сервера: {str(e)}'}, 500
