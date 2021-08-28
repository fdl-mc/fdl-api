import 'package:firebase_admin/firebase_admin.dart';
import 'package:firebase_admin/src/auth/credential.dart';

final firebase = FirebaseAdmin.instance.initializeApp(
  AppOptions(
    credential: ServiceAccountCredential('admin.json'),
  ),
);

final auth = firebase.auth();
