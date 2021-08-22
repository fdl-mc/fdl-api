from flask import Flask
from flask_cors import CORS
from routes.stats import stats_bp
from routes.economy import economy_bp

# Initialize and configure server, setup CORS
app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False
CORS(app)

# Register routes
app.register_blueprint(stats_bp, url_prefix='/stats')
app.register_blueprint(economy_bp, url_prefix='/economy')

if __name__ == '__main__':
    from waitress import serve
    serve(app, port=3000)
