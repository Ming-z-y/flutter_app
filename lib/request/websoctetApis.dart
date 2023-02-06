import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class WebSocketAPIS {
  static WebSocketAPIS instance = WebSocketAPIS._internal();
  factory WebSocketAPIS() => instance;
  IOWebSocketChannel? _channel;
  static late var likeMessage;
  static late var focusMessage;
  static late var collectionMessage;
  static late var commentMessage;

  WebSocketAPIS._internal() {
    if (_channel == null) {
      _channel = IOWebSocketChannel.connect("");
      _channel!.stream.listen((message) {
        print("收到信息");
      });
    }
  }

  getLikeMessage() {
    return WebSocketAPIS.likeMessage;
  }

  getFocusMessage() {
    return WebSocketAPIS.focusMessage;
  }

  getCollectionMessage() {
    return WebSocketAPIS.collectionMessage;
  }

  getCommentMessage() {
    return WebSocketAPIS.commentMessage;
  }
}
