import 'package:fdl_server/src/shared/instances.dart';
import 'package:fdl_server/src/utils/config.dart';
import 'package:firebase_admin/firebase_admin.dart';
import 'package:firebase_admin/src/auth/credential.dart';
import 'package:mongo_dart/mongo_dart.dart';

Future<void> initializeServices(Config config) async {
  firebase = FirebaseAdmin.instance.initializeApp(
    AppOptions(credential: ServiceAccountCredential('admin.json')),
  );

  database = await Db.create(config.mongodbUrl);
  await database.open();
}
