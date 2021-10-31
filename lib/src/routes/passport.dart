import 'dart:convert';

import 'package:fdl_server/src/interfaces/controller.dart';
import 'package:fdl_server/src/shared/builders.dart';
import 'package:fdl_server/src/shared/instances.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class PassportController extends IController {
  @override
  Router get router {
    final router = Router();

    router.get('/find', findUsers);
    router.get('/<id>', getUser);

    return router;
  }

  Future<Response> getUser(Request request) async {
    final query = request.params['id']!;

    final user = await database.collection('users').findOne(
          where
              .eq('_id', query)
              .or(where.eq('discordId', query))
              .or(where.eq('nickname', query)),
        );

    if (user == null) {
      return Response.notFound(
        Builders.userNotFoundError.build(),
      );
    }

    return Response.ok(jsonEncode(user));
  }

  Future<Response> findUsers(Request request) async {
    final query = request.url.queryParameters['query']!;

    final users = await database
        .collection('users')
        .find(where.match('nickname', query, caseInsensitive: true))
        .toList();

    return Response.ok(jsonEncode(users));
  }
}
