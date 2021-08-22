from flask import Blueprint, request
from shared.instances import db

economy_bp = Blueprint('economy', __name__)


@economy_bp.route('/pay')
def pay():
    try:
        args = request.args.to_dict()

        payer = args['payer']
        payee = args['payee']
        amount = int(args['amount'])

        payer_doc = db.collection('users').document(payer).get()
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
