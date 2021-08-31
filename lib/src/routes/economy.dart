import 'package:fdl_server/src/interfaces/controller.dart';
import 'package:fdl_server/src/middlewares/auth_check.dart';
import 'package:fdl_server/src/middlewares/post_args_check.dart';
import 'package:fdl_server/src/shared/instances.dart';
import 'package:fdl_server/src/utils/get_auth_details.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class EconomyController extends IController {
  @override
  Router get router {
    final router = Router();

    router.post(
      '/pay',
      Pipeline()
          .addMiddleware(
            AuthCheckMiddleware().middleware(),
          )
          .addMiddleware(
            PostArgsMiddleware(requiredArgs: ['payee', 'amount']).middleware(),
          )
          .addHandler(pay),
    );

    return router;
  }

  Future<Response> pay(Request request) async {
    final args = request.context['body'] as Map<String, String>;

    // fetch args
    final payeeName = args['payee']!;
    final amount = int.tryParse(args['amount']!);
    final comment = args['comment'];
    final payerId = (await getAuthDetails(request))['user_id']! as String;

    // get database collections
    final passports = database.collection('passports');
    final economy = database.collection('economy');

    // find payee passport by nickname
    final payeePassport = await passports.findOne(
      where.eq('nickname', payeeName),
    );
    if (payeePassport == null) {
      return Response.notFound({
        'errorCode': 404,
        'message': 'Пользователь не найден.',
      }.toString());
    }
    final payeeId = payeePassport['_id'];

    // find payer and payee economy states by id
    final payerEconomy = (await economy.findOne(where.eq('_id', payerId)))!;
    final payeeEconomy = (await economy.findOne(where.eq('_id', payeeId)))!;

    // check for payer funds
    if (payerEconomy['balance'] < amount) {
      return Response.forbidden({
        'errorCode': 403,
        'message': 'Недостаточно средств.',
      }.toString());
    }

    // update payee balance
    await economy.updateOne(
      where.eq('_id', payeeId),
      modify.set('balance', payeeEconomy['balance'] + amount),
    );

    // update payer balance
    await economy.updateOne(
      where.eq('_id', payerId),
      modify.set('balance', payerEconomy['balance'] - amount),
    );

    return Response.ok({
      'message': 'Успшено переведено $amount ИБ пользователю $payeeName.',
    }.toString());
  }
}
