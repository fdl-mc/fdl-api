import 'dart:io';

class Config {
  final String mongodbUrl;
  final int port;

  Config({
    required this.mongodbUrl,
    required this.port,
  });

  Config.fromEnviroment()
      : mongodbUrl = Platform.environment['FDL_SERVER_MONGODB_URL']!,
        port = int.tryParse(Platform.environment['FDL_SERVER_PORT']!)!;
}
