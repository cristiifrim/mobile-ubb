import 'package:web_socket_channel/io.dart';

class WebSocketManager {
  final String serverUrl;
  final Function(String) onMessageReceived;
  late IOWebSocketChannel _channel;

  WebSocketManager._(
      {required this.serverUrl, required this.onMessageReceived}) {
    _channel = IOWebSocketChannel.connect(serverUrl);
    _setupWebSocketListener();
  }

  factory WebSocketManager(
      {required String serverUrl,
      required Function(String) onMessageReceived}) {
    return WebSocketManager._(
        serverUrl: serverUrl, onMessageReceived: onMessageReceived);
  }

  void _setupWebSocketListener() {
    _channel.stream.listen(
      (message) {
        onMessageReceived(message);
      },
      onDone: () {
        print('WebSocket closed');
      },
      onError: (error) {
        print('WebSocket error: $error');
      },
      cancelOnError: true,
    );
  }

  void disconnect() {
    _channel.sink.close();
  }
}
