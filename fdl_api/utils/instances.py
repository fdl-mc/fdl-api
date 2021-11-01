from firebase_admin import initialize_app, firestore
from firebase_admin.credentials import Certificate
from fdl_api.utils.settings import Settings


settings = Settings()
firebase = initialize_app(credential=Certificate(settings.fba_credentials))
db = firestore.client(app=firebase)
