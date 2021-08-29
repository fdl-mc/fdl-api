import 'package:fdl_server/src/middlewares/logging.dart';
import 'package:fdl_server/src/routes/economy.dart';
import 'package:fdl_server/src/routes/stats.dart';
import 'package:fdl_server/src/utils/config.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' show serve;

void main(List<String> arguments) {
  final app = Router();
  final config = Config.fromEnviroment();

  app.mount(
    '/v1/',
    Router()
      ..mount('/economy/', EconomyController().router)
      ..mount('/stats/', StatsController().router),
  );

  final handler = Pipeline().addMiddleware(loggingMiddleware()).addHandler(app);

  serve(handler, '0.0.0.0', config.port);
}
