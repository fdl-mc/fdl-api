import 'package:fdl_server/src/interfaces/middleware.dart';
import 'package:fdl_server/src/shared/instances.dart';
import 'package:shelf/shelf.dart';

/// Verify auth id token.
class AuthCheckMiddleware extends IMiddleware {
  final auth = firebase.auth();

  @override
  Middleware middleware() {
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
}
