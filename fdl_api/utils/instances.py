from firebase_admin import initialize_app, firestore
from firebase_admin.credentials import Certificate
from fdl_api.utils.settings import Settings
from google.cloud.firestore import Client as FirestoreClient

settings = Settings()
firebase = initialize_app(credential=Certificate(settings.fba_credentials))
db: FirestoreClient = firestore.client(app=firebase)
