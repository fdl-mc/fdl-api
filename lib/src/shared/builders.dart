// ignore: implementation_imports
import 'package:dart_minecraft/src/packet/packets/response_packet.dart';
import 'package:fdl_server/src/builders/error.dart';
import 'package:fdl_server/src/builders/server_stats.dart';

class Builders {
  static final userNotFoundError = ErrorMessageBuilder(
    errorCode: 404,
    errorStatus: 'USER_NOT_FOUND',
    errorMessage: 'Пользователь не найден.',
  );

  static final insufficientFundsError = ErrorMessageBuilder(
    errorCode: 403,
    errorStatus: 'INSUFFICIENT_FUNDS',
    errorMessage: 'Недостаточно средств.',
  );

  static final noTokenProvidedError = ErrorMessageBuilder(
    errorCode: 401,
    errorStatus: 'NO_TOKEN_PROVIDED',
    errorMessage: 'Пустой токен.',
  );

  static final unauthorizedError = ErrorMessageBuilder(
    errorCode: 401,
    errorStatus: 'UNAUTHORIZED',
    errorMessage: 'Неудачная аутентификация.',
  );

  static getNotEnoughArgsError(String arg) {
    return ErrorMessageBuilder(
      errorCode: 400,
      errorStatus: 'NOT_ENOUGH_ARGS',
      errorMessage: 'Необходим аргумент $arg',
    );
  }

  static getServerStatsFromResponse(
    ResponsePacket server, {
    // TODO: replace with Uri
    required String ip,
    required int port,
  }) {
    final response = server.response!;

    return ServerStatsBuilder(
      ip: ip,
      port: port,
      description: response.description.description,
      version: response.version.name.split(' ').last,
      latency: server.ping,
      players: PlayersStatsBuilder(
        online: response.players.online,
        max: response.players.max,
        names: response.players.sample.map((e) => e.name).toList(),
      ),
    );
  }
}
