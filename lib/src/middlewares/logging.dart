import 'package:shelf/shelf.dart';

/// Logs all incoming request
Middleware loggingMiddleware() {
  return (innerHandler) {
    return (request) async {
      print(
        '[${DateTime.now().toString().split('.').first}] ${request.method} /${request.url.path}',
      );
      // return Response(200, body: 'morgenshtern');
      return innerHandler(request);
    };
  };
}
