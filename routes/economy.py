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

        try:
            payee_obj = db.collection('users').where(
                'name', '==', payee).get()[0]
        except IndexError:
            return 'user-not-found'

        payer_obj.reference.update(
            {'balance': payer_obj.to_dict()['balance'] - amount})
        payee_obj.reference.update(
            {'balance': payee_obj.to_dict()['balance'] + amount})

        return 'ok'
    except Exception as e:
        return str(e)
