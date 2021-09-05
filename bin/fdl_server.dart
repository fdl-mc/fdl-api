import 'package:fdl_server/src/middlewares/body_parser.dart';
import 'package:fdl_server/src/middlewares/cors.dart';
import 'package:fdl_server/src/middlewares/logging.dart';
import 'package:fdl_server/src/routes/economy.dart';
import 'package:fdl_server/src/routes/passport.dart';
import 'package:fdl_server/src/routes/stats.dart';
import 'package:fdl_server/src/utils/config.dart';
import 'package:fdl_server/src/utils/initialize_services.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' show serve;

Future<void> main() async {
  final config = Config.fromEnviroment();
  await initializeServices(config).then(
    (_) => print('Services have been initialized'),
  );

  final app = Router();
  app.mount(
    '/v1/',
    Router()
      ..mount('/economy/', EconomyController().router)
      ..mount('/stats/', StatsController().router)
      ..mount('/passport/', PassportController().router),
  );

  final handler = Pipeline()
      .addMiddleware(CorsMiddleware().middleware())
      .addMiddleware(LoggingMiddleware().middleware())
      .addMiddleware(BodyParserMiddleware().middleware())
      .addHandler(app);

  await serve(handler, '0.0.0.0', config.port).then(
    (_) => print('Server is running!'),
  );
}
