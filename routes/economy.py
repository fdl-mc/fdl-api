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

        payer_obj = db.collection('users').document(payer).get()
        payer_balance = payer_obj.to_dict()['balance']

        if payer_balance < amount:
            return {
                "message": "Недостаточно средств."
            }, 403

        try:
            payee_obj = db.collection('users').where(
                'name', '==', payee).get()[0]
        except IndexError:
            return {
                'message': 'Пользователь не найден.'
            }, 404

        payee_balance = payee_obj.to_dict()['balance']

        payer_obj.reference.update({'balance': payer_balance - amount})
        payee_obj.reference.update({'balance': payee_balance + amount})

        return {
            'message': f'Успешно переведено ${amount} ИБ пользователю ${payee}!'
        }, 200

    except Exception as e:
        return {
            'message': f'Внутренняя ошибка сервера: {str(e)}'
        }, 500
