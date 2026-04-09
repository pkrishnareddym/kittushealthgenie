import 'package:web_socket_channel/web_socket_channel.dart';

class SocketService {
  final channel = WebSocketChannel.connect(Uri.parse('ws://10.0.2.2:3000'));

  void sendVitals(dynamic v) {
    channel.sink.add(v.toString());
  }

  Stream get stream => channel.stream;

  void dispose() {
    channel.sink.close();
  }
}
