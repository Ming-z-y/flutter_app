import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../publishArticle/uploadResult.dart';

Future<File> saveStringToFile(String content) async {
  // requestPermission();
  // 创建临时目录文件夹
  final filepath = await getTemporaryDirectory();
  var directory = Directory('${filepath.path}/article');
  try {
    bool exists = await directory.exists();
    if (!exists) {
      await directory.create();
    }
  } catch (e) {}
  // 创建文件
  File file = File("${directory.path}/article.txt");
  try {
    if (!await file.exists()) {
      await file.create();
    }
  } catch (e) {}
  File f = await file.writeAsString(content);
  return f;
}

Future<String?> selectAndUploadVideo(String path) async {
  if (path == 'error') return null;

  String categoryCode = 'myVideo';
  String token = await getOSSToken();

  Map<String, dynamic>? data = await saveQNYFile(File(path), token, 'test');
  // String name = data!["key"];
  return 'http://video.smaa.club/my_video';
}
