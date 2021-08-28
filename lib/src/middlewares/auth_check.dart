import 'package:fdl_server/src/shared/instances.dart';
import 'package:shelf/shelf.dart';

/// Verifies auth id token
Middleware authCheckMiddleware() {
  return (innerHandler) {
    return (request) async {
      final token = request.headers['Authorization'];

      if (token == null || token.trim() == '') {
        return Response(
          401,
          body: {
            'status': 401,
            'message': 'Пустой токен.',
          }.toString(),
        );
      }

      try {
        await auth.verifyIdToken(token, true);
      } catch (e) {
        return Response(
          401,
          body: {
            'status': 401,
            'message': 'Неудачная аутентификация.',
          }.toString(),
        );
      }

      return innerHandler(request);
    };
  };
}
