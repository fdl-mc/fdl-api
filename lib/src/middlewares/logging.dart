import 'package:fdl_server/src/interfaces/middleware.dart';
import 'package:fdl_server/src/utils/get_ip.dart';
import 'package:shelf/shelf.dart';

/// Log all incoming requests.
class LoggingMiddleware extends IMiddleware {
  @override
  Middleware middleware() {
    return (innerHandler) {
      return (request) async {
        print(
          '[${DateTime.now().toString().split('.').first}] ${request.method} /${request.url.path} | Requested by ${getIp(request)}',
        );
        // return Response(200, body: 'morgenshtern');
        return innerHandler(request);
      };
    };
  }
}
