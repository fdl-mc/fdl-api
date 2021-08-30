import 'package:fdl_server/src/middlewares/logging.dart';
import 'package:fdl_server/src/routes/economy.dart';
import 'package:fdl_server/src/routes/stats.dart';
import 'package:fdl_server/src/shared/instances.dart';
import 'package:fdl_server/src/utils/config.dart';
import 'package:fdl_server/src/utils/initialize_services.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' show serve;

Future<void> main() async {
  final config = Config.fromEnviroment();
  await initializeServices(config);

  final app = Router();
  app.mount(
    '/v1/',
    Router()
      ..mount('/economy/', EconomyController().router)
      ..mount('/stats/', StatsController().router),
  );

  final handler = Pipeline()
      .addMiddleware(LoggingMiddleware().middleware())
      .addHandler(app);

  await serve(handler, '0.0.0.0', config.port);
}
