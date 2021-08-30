import 'package:fdl_server/src/shared/instances.dart';
import 'package:firebase_admin/firebase_admin.dart';
import 'package:firebase_admin/src/auth/credential.dart';

Future<void> initializeServices() async {
  firebase = FirebaseAdmin.instance.initializeApp(
    AppOptions(credential: ServiceAccountCredential('admin.json')),
  );
}
