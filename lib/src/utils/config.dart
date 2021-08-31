import 'dart:convert';
import 'dart:io';

/// Provides app configuration.
class Config {
  /// MongoDB URL.
  final String mongodbUrl;

  /// Firebase Admin JSON credentials.
  final Map<String, dynamic> firebaseAdminCredentials;

  /// Server port.
  final int port;

  Config({
    required this.mongodbUrl,
    required this.port,
    required this.firebaseAdminCredentials,
  });

  /// Parse environment variables.
  /// - FDL_SERVER_MONGODB_URL for [mongodbUrl]
  /// - FDL_SERVER_PORT for [port]
  /// - FDL_SERVER_FBA_CREDENTIALS for [firebaseAdminCredentials]
  Config.fromEnviroment()
      : mongodbUrl = Platform.environment['FDL_SERVER_MONGODB_URL']!,
        port = int.tryParse(Platform.environment['FDL_SERVER_PORT']!)!,
        firebaseAdminCredentials = jsonDecode(
          Platform.environment['FDL_SERVER_FBA_CREDENTIALS']!,
        );
}
