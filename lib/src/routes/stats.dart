import 'dart:convert';

import 'package:dart_minecraft/dart_minecraft.dart';
import 'package:fdl_server/src/interfaces/controller.dart';
import 'package:fdl_server/src/shared/builders.dart';
import 'package:fdl_server/src/utils/config.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

/// Provide stats routes.
class StatsController extends IController {
  Config config;

  StatsController({required this.config});

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
      config.mainServerIp.host,
      port: config.mainServerIp.port,
      timeout: Duration(seconds: 5),
    );

    return Response.ok(
      Builders.getServerStatsFromResponse(
        server!,
        ip: config.mainServerIp,
      ).build(),
    );
  }

  /// Fetch creative server stats.
  Future<Response> _creativeStats(Request request) async {
    final server = await ping(
      config.creativeServerIp.host,
      port: config.creativeServerIp.port,
      timeout: Duration(seconds: 5),
    );

    return Response.ok(
      Builders.getServerStatsFromResponse(
        server!,
        ip: config.creativeServerIp,
      ).build(),
    );
  }
}
