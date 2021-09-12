/// A parsed Minecraft server IP.
class MinecraftIp {
  /// Minecraft server hostname.
  final String host;

  /// Minecraft server port.
  final int port;

  MinecraftIp({
    required this.host,
    required this.port,
  });

  /// Parses from given ip string, e.g. `example.com:25565`.
  MinecraftIp.parse(String ip)
      : host = ip.split(':')[0],
        port = ip.split(':').length > 1 ? int.parse(ip.split(':')[1]) : 25565;
}
