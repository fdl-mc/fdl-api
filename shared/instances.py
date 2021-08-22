from firebase_admin import initialize_app, firestore, credentials

# Firebase intsance
fb = initialize_app(credential=credentials.Certificate('./admin.json'))

# Firestore instasnce
db = firestore.client(app=fb)
