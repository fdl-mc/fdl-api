import 'package:fdl_server/src/shared/instances.dart';
import 'package:shelf/shelf.dart';

/// Get user data from Authorization header.
Future<Map<String, dynamic>> getAuthDetails(Request request) async {
  final token = request.headers['Authorization'];
  return (await firebase.auth().verifyIdToken(token!)).claims.toJson();
}
