import 'package:fdl_server/src/routes/economy.dart';
import 'package:fdl_server/src/routes/stats.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' show serve;

void main(List<String> arguments) {
  final app = Router();

  app
    ..mount('/economy', EconomyController().router)
    ..mount('/stats', StatsController().router);

  final handler = Pipeline().addHandler(app);

  serve(handler, '0.0.0.0', 3000);
}
