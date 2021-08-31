import 'package:fdl_server/src/interfaces/middleware.dart';
import 'package:shelf/shelf.dart';

/// Adds CORS headers
class CorsMiddleware extends IMiddleware {
  static const _headers = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': '*',
    'Access-Control-Allow-Methods': '*',
  };

  @override
  Middleware middleware() {
    return (innerHandler) {
      return (request) async {
        request = request.change(headers: _headers);
        return innerHandler(request);
      };
    };
  }
}
