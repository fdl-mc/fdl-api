import 'package:dart_minecraft/dart_minecraft.dart';
import 'package:fdl_server/src/interfaces/controller.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

/// Provide stats routes.
class StatsController extends IController {
  @override
  Router get router {
    final router = Router();

    router.get('/main', _mainStats);
    router.get('/creative', _creativeStats);

    return router;
  }

  /// Fetch main server stats.
  Future<Response> _mainStats(Request request) async {
    final server = await ping(
      'play.fdl-mc.ru',
      port: 25565,
      timeout: Duration(seconds: 5),
    );
    final response = server!.response!;

    return Response.ok({
      'ip': 'play.fdl-mc.ru',
      'port': 25565,
      'description': response.description.description,
      'version': response.version.name.split(' ').last,
      'latency': server.ping,
      'players': {
        'online': response.players.online,
        'max': response.players.max,
        'names': response.players.sample.map((e) => e.name).toList(),
      }
    }.toString());
  }

  /// Fetch creative server stats.
  Future<Response> _creativeStats(Request request) async {
    final server = await ping(
      'creative.fdl-mc.ru',
      port: 25565,
      timeout: Duration(seconds: 5),
    );
    final response = server!.response!;

    return Response.ok({
      'ip': 'creative.fdl-mc.ru',
      'port': 25565,
      'description': response.description.description,
      'version': response.version.name.split(' ').last,
      'latency': server.ping,
      'players': {
        'online': response.players.online,
        'max': response.players.max,
        'names': response.players.sample.map((e) => e.name).toList(),
      }
    }.toString());
  }
}
