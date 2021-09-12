import 'package:fdl_server/src/interfaces/middleware.dart';
import 'package:fdl_server/src/shared/builders.dart';
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
          return Response(401, body: Builders.noTokenProvidedError.build());
        }

        try {
          await auth.verifyIdToken(token, true);
        } catch (e) {
          return Response(401, body: Builders.unauthorizedError.build());
        }

        return innerHandler(request);
      };
    };
  }
}
