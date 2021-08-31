import 'package:fdl_server/src/interfaces/middleware.dart';
import 'package:shelf/shelf.dart';

/// Parse body and add it into context.
class BodyParserMiddleware extends IMiddleware {
  @override
  Middleware middleware() {
    return (innerHandler) {
      return (request) async {
        request = request.change(context: {'body': await _parseBody(request)});
        return innerHandler(request);
      };
    };
  }

  /// Parse [request]'s body form into [Map]
  Future<Map<String, String>> _parseBody(Request request) async {
    final query = Uri.splitQueryString(await request.readAsString());
    return query;
  }
}
