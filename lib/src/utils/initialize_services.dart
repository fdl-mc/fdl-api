import 'package:fdl_server/src/shared/instances.dart';
import 'package:fdl_server/src/utils/config.dart';
import 'package:firebase_admin/firebase_admin.dart';
// ignore: implementation_imports
import 'package:firebase_admin/src/auth/credential.dart';
import 'package:mongo_dart/mongo_dart.dart';

/// Initialize all instances and services from [config].
Future<void> initializeServices(Config config) async {
  firebase = FirebaseAdmin.instance.initializeApp(
    AppOptions(
      credential: ServiceAccountCredential(config.firebaseAdminCredentials),
    ),
  );

  database = await Db.create(config.mongodbUrl.toString());
  await database.open();
}
