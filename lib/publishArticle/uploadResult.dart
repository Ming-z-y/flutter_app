import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qiniu_flutter_sdk/qiniu_flutter_sdk.dart';

import '../request/apis.dart';

class UploadResult {
  final String uploadVideoPath;

  UploadResult(this.uploadVideoPath);
}

/// path 为本地空间的地址, 本函数上传至七牛 oss
Future<UploadResult?> selectAndUploadVideo(String path, String name) async {
  if (path == 'error') return null;

  String categoryCode = 'myVideo';
  String token = await getOSSToken();

  Map<String, dynamic>? data = await saveQNYFile(File(path), token, 'test');
  // String name = data!["key"];
  return UploadResult('http://video.smaa.club/my_video');
}

Future<String> chooseVideoPath({bool isGetCamera = false}) async {
  // EasyLoading.showInfo('加载中');
  final XFile? file = await ImagePicker().pickVideo(
      source: isGetCamera ? ImageSource.camera : ImageSource.gallery);
  // EasyLoading.dismiss();
  if (file == null)
    return 'error';
  else
    return file.path;
}

Future<Map<String, dynamic>?> saveQNYFile(
    File fi, String token, String key) async {
  // 创建 storage 对象
  Storage storage = Storage();
  // 创建 putController 对象
  PutController putController = PutController();
  // 添加任务进度监听
  putController.addProgressListener((double percent) {
    print('任务进度变化：已发送：$percent');
  });
  // 添加文件发送进度监听
  putController.addSendProgressListener((double percent) {
    print('已上传进度变化：已发送：$percent');
  });
  // 添加任务状态监听
  putController.addStatusListener((StorageStatus status) {
    print('状态变化: 当前任务状态：$status');
  });
  var res = await storage.putFile(fi, token,
      options: PutOptions(controller: putController, key: key));

  return res.rawData;
}

Future<String> getOSSToken() async {
  var ossToken;
  await APIS.getOSSToken().then((value) {
    if (value.status == 10001) ossToken = value.data!["upload_token"];
  });
  return ossToken;
}
