import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class VitalsStreamService {
  final channel = WebSocketChannel.connect(
    Uri.parse('wss://your-server/vitals'),
  );

  Stream<Map<String, dynamic>> get stream =>
      channel.stream.map((e) => jsonDecode(e));
}
