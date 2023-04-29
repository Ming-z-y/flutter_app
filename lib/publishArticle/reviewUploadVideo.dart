import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/publishArticle/publishVideoWeapper.dart';
import 'package:flutter_application_1/request/apis.dart';
import 'package:flutter_application_1/utils/chooseImg.dart';
import 'package:flutter_application_1/utils/chooseIsGetCamera.dart';
import 'package:flutter_application_1/utils/crop_image.dart';
import 'package:flutter_application_1/utils/showLoadingDialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../utils/queryIsChecked.dart';
import 'chooseCategory.dart';

class ReviewUploadVideo extends StatefulWidget {
  const ReviewUploadVideo({super.key, required this.url});
  final String url;

  @override
  State<StatefulWidget> createState() => _ReviewUploadVideo();
}

class _ReviewUploadVideo extends State<ReviewUploadVideo> {
  String category = '选择分区';
  String cover = '选择封面';
  String coverPath = '';
  TextEditingController _controller = TextEditingController();

  _chooseCategory() async {
    String? t = await chooseCategory(context: context);
    if (t != null) {
      setState(() {
        category = t;
      });
    }
  }

  _upload() async {
    String localVideoUrl = widget.url;
    String name = _controller.text;
    if (localVideoUrl == 'error' ||
        name == '' ||
        category == '选择分区' ||
        cover == '选择封面') {
      return Fluttertoast.showToast(msg: '未填写完整信息');
    } else {
      await queryIsChecked(
        context: context,
        onOk: () async {
          showLoadingDialog(context);
          String? pathVideo = await uploadToOss(localVideoUrl, name, 2);
          String? pathPhoto = await uploadToOss(coverPath, "cover-$name", 1);
          print(pathVideo);
          print(pathPhoto);
          // String? croppedImage = await crop_image(
          //   context: context,
          //   sourcePath: pathPhoto ?? '',
          //   maxHeight: 329,
          //   maxWidth: 190,
          // );
          if (pathPhoto != null && pathVideo != null) {
            await APIS
                .publishWork(
              scope: 2,
              title: name,
              image_url: pathPhoto,
              content_url: pathVideo,
              work_class: category,
            )
                .then((value) {
              print(value.status);
              if (value.status == 10001) {
                print('上传成功');
                Fluttertoast.showToast(msg: '作品发布成功');
              }
            });
          } else {
            print('上传失败');
          }
          Navigator.pop(context);
          Navigator.pop(context);
        },
      );
    }
  }

  _uploadToBack() async {}

  _chooseCover() async {
    int? isGetCamera = await chooseIsGetCamera(context: context);
    ChooseMethod.setIsGetCamera(0);
    String path = 'error';
    if (isGetCamera == 0) return;
    if (isGetCamera == 1) {
      path = await choosePhotoPath(isGetCamera: true);
    } else if (isGetCamera == 2) {
      path = await choosePhotoPath(isGetCamera: false);
    }
    if (path != 'error') {
      String? croppedpath = await crop_image(
          sourcePath: path, context: context, maxHeight: 190, maxWidth: 329);
      if (croppedpath != null) {
        coverPath = croppedpath;
        print(path);
        setState(() {
          cover = '已选择';
        });
      } else {
        print('出错了');
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 40,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(65, 53, 85, 1),
        ),
        title: const Text(
          '上传视频',
          style: TextStyle(
            color: Color.fromRGBO(65, 53, 85, 1),
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _upload,
            child: const Text(
              '上传',
              style: TextStyle(
                color: Color.fromRGBO(65, 53, 85, 1),
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
      body: PublishVideoWeapper(
        url: widget.url,
        child: Container(
          height: 370,
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.5, //宽度
                      color: Color.fromARGB(255, 163, 159, 159), //边框颜色
                    ),
                  ),
                ),
                child: TextButton(
                  onPressed: _chooseCategory,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        category,
                        style:
                            const TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.5, //宽度
                      color: Color.fromARGB(255, 163, 159, 159), //边框颜色
                    ),
                  ),
                ),
                padding: EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  controller: _controller,
                  cursorColor: Colors.amber,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusColor: Color.fromRGBO(125, 122, 238, 1),
                    hintText: '请输入视频标题（5-31个字）',
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.5, //宽度
                      color: Color.fromARGB(255, 163, 159, 159), //边框颜色
                    ),
                  ),
                ),
                child: TextButton(
                  onPressed: _chooseCover,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cover,
                        style:
                            const TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
