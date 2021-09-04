import 'package:fdl_server/src/interfaces/middleware.dart';
import 'package:shelf/shelf.dart';

/// Check for required POST parameters.
class PostArgsMiddleware extends IMiddleware {
  final List<String> requiredArgs;

  PostArgsMiddleware({required this.requiredArgs});

  @override
  Middleware middleware() {
    return (innerHandler) {
      return (request) async {
        final args = request.context['body'] as Map<String, dynamic>;

        for (var i = 0; i < requiredArgs.length; i++) {
          if (!args.containsKey(requiredArgs[i])) {
            return Response(
              400,
              body: {
                'errorCode': 400,
                'errorMsg': 'Необходим аргумент ${requiredArgs[i]}',
              }.toString(),
            );
          }
        }

        return innerHandler(request);
      };
    };
  }
}
