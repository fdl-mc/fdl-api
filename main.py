from firebase_admin import credentials
from flask import Flask, request
from firebase_admin import initialize_app, firestore, credentials
from flask_cors import CORS
from routes.stats import stats_bp

fb = initialize_app(credential=credentials.Certificate('./admin.json'))
db = firestore.client(app=fb)

app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False
CORS(app)

app.register_blueprint(stats_bp, url_prefix='/stats')


@app.route("/pay")
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


if __name__ == "__main__":
    from waitress import serve
    serve(app, port=3000)
