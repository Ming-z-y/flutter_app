import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/request/base_config.dart';
import 'package:flutter_application_1/utils/cache.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketChannel extends ChangeNotifier {
  // 创建WebSocketChannel 单利，全局只有一个对象
  WebSocketChannel._privateConstructor();
  late BuildContext contexts;
  static late IOWebSocketChannel channel;

  static final WebSocketChannel _instance =
      WebSocketChannel._privateConstructor();

  static WebSocketChannel get instance {
    return _instance;
  }

  static List newData = [];

  // 开始进行链接
  void connect() {
    print('AppCache.token');
    print(AppCache.token);
    channel = IOWebSocketChannel.connect('ws://${BASE_Config.HOST}/message',
        headers: {"Cookie": AppCache.token});
    channel.stream.listen(this.onData, onError: onError, onDone: onDone);
  }

  // 断连，然后执行重连
  onDone() async {
    await Future.delayed(const Duration(milliseconds: 15000), () {
      debugPrint("Socket is closed");
      channel = IOWebSocketChannel.connect('wss://${BASE_Config.HOST}/message',
          headers: {"Cookie": AppCache.token});
      channel.stream.listen(this.onData, onError: onError, onDone: onDone);
    });
  }

  // 错误日志
  onError(err) {
    debugPrint(err.runtimeType.toString());
    WebSocketChannelException ex = err;
    debugPrint(ex.message);
  }

  // 接受数据，数据json字符串，然后转成Map
  onData(event) {
    newData = json.decode(event);
    notifyListeners();
  }

  static close() {
    channel.sink.close();
  }
}
