import 'dart:convert';
import 'dart:io';

class Config {
  final String mongodbUrl;
  final Map<String, dynamic> firebaseAdminCredentials;
  final int port;

  Config({
    required this.mongodbUrl,
    required this.port,
    required this.firebaseAdminCredentials,
  });

  Config.fromEnviroment()
      : mongodbUrl = Platform.environment['FDL_SERVER_MONGODB_URL']!,
        port = int.tryParse(Platform.environment['FDL_SERVER_PORT']!)!,
        firebaseAdminCredentials = jsonDecode(
          Platform.environment['FDL_SERVER_FBA_CREDENTIALS']!,
        );
}
