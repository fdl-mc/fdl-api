import 'dart:convert';

import 'package:fdl_server/src/interfaces/builder.dart';

class ServerStatsBuilder implements IBuilder<String> {
  String? ip;
  int? port;
  String? description;
  String? version;
  int? latency;
  PlayersStatsBuilder? players;

  ServerStatsBuilder({
    this.ip,
    this.port,
    this.description,
    this.version,
    this.latency,
    this.players,
  });

  @override
  String build() {
    return jsonEncode({
      'ip': ip!,
      'port': port!,
      'description': description!,
      'version': version!,
      'latency': latency!,
      'players': players!.build(),
    });
  }
}

class PlayersStatsBuilder implements IBuilder<Map<String, dynamic>> {
  int? online;
  int? max;
  List<String>? names;

  PlayersStatsBuilder({
    this.online,
    this.max,
    this.names,
  });

  @override
  Map<String, dynamic> build() {
    return {
      'online': online!,
      'max': max!,
      'names': names!,
    };
  }
}
