import 'dart:convert';
import 'dart:io';

import 'package:fdl_server/src/utils/minecraft_ip.dart';

/// Provides app configuration.
class Config {
  /// MongoDB URL.
  final Uri mongodbUrl;

  /// Firebase Admin JSON credentials.
  final Map<String, dynamic> firebaseAdminCredentials;

  /// Server port.
  final int port;

  /// Main MC server ip, e.g. example.com:25565
  final MinecraftIp mainServerIp;

  /// Creative MC server ip, e.g. example.com:25565
  final MinecraftIp creativeServerIp;

  Config({
    required this.mongodbUrl,
    required this.port,
    required this.firebaseAdminCredentials,
    required this.mainServerIp,
    required this.creativeServerIp,
  });

  /// Parse environment variables.
  /// - `FDL_SERVER_MONGODB_URL` for [mongodbUrl]
  /// - `FDL_SERVER_PORT for` [port]
  /// - `FDL_SERVER_FBA_CREDENTIALS` for [firebaseAdminCredentials]
  /// - `FDL_SERVER_MAIN_IP` for [mainServerIp]
  /// - `FDL_SERVER_CREATIVE_IP` for [creativeServerIp]
  Config.fromEnviroment()
      : mongodbUrl = Uri.parse(
          Platform.environment['FDL_SERVER_MONGODB_URL']!,
        ),
        port = int.tryParse(
          Platform.environment['FDL_SERVER_PORT']!,
        )!,
        firebaseAdminCredentials = jsonDecode(
          Platform.environment['FDL_SERVER_FBA_CREDENTIALS']!,
        ),
        mainServerIp = MinecraftIp.parse(
          Platform.environment['FDL_SERVER_MAIN_IP']!,
        ),
        creativeServerIp = MinecraftIp.parse(
          Platform.environment['FDL_SERVER_CREATIVE_IP']!,
        );
}
