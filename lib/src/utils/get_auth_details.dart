import 'package:fdl_server/src/shared/instances.dart';
import 'package:shelf/shelf.dart';

Future<Map<String, dynamic>> getAuthDetails(Request request) async {
  final token = request.headers['Authorization'];
  return (await firebase.auth().verifyIdToken(token!)).claims.toJson();
}
