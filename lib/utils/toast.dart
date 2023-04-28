import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// toast 提示
class DuToast {
  /// 显示
  static void show(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
