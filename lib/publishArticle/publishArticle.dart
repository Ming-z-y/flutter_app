import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/queryIsChecked.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import '../request/apis.dart';
import '../utils/chooseImg.dart';
import '../utils/chooseIsGetCamera.dart';
import '../utils/createFile.dart';
import '../utils/crop_image.dart';
import '../utils/showLoadingDialog.dart';
import 'chooseCategory.dart';

class PublishArticle extends StatefulWidget {
  const PublishArticle({super.key});

  @override
  State<PublishArticle> createState() {
    return _PublishArticle();
  }
}

class _PublishArticle extends State<PublishArticle> {
  String cover = '选择封面';
  String coverPath = '';
  final HtmlEditorController _controller = HtmlEditorController();
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _vicetextController = TextEditingController();

  // 选择的分区名称
  String category = '选择分区';

  @override
  void initState() {
    super.initState();
  }

  _chooseCategory() async {
    String? cate = await chooseCategory(context: context);
    if (cate != null) {
      setState(() {
        category = cate;
      });
    }
  }

  _uploadArticle() async {
    File file = await saveStringToFile(await _controller.getText());
    print(await file.readAsString());
  }

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

  _upload() async {
    // 文章信息
    String content = await _controller.getText();
    // 作品名称
    String workName = _textController.text;
    String outlined = _vicetextController.text;
    if (content == '' ||
        workName == '' ||
        category == '选择分区' ||
        cover == '选择封面' ||
        outlined == '') {
      return Fluttertoast.showToast(msg: '未填写完整信息');
    }
    await queryIsChecked(
      context: context,
      onOk: (() async {
        showLoadingDialog(context);
        // 将内容写入文件
        File file = await saveStringToFile(content);
        print(file.path);
        print(coverPath);
        // 将内容和封面传至oss
        String? pathfile = await uploadToOss(file.path, workName, 3);
        String? pathPhoto = await uploadToOss(coverPath, "cover-$workName", 1);
        print(pathfile);
        print(pathPhoto);
        if (pathfile != null && pathPhoto != null) {
          await APIS
              .publishWork(
            scope: 1,
            title: workName,
            image_url: pathPhoto,
            content_url: pathfile,
            work_class: category,
            outlined: outlined,
          )
              .then((value) {
            print(value.status);
            print(value.info);
            if (value.status == 10001) {
              print('上传成功');
              Fluttertoast.showToast(msg: '作品发布成功');
            } else {
              print('网络出问题了，请稍后再试');
            }
          });
        } else {
          print('上传失败');
        }
        Navigator.pop(context);
        Navigator.pop(context);
      }),
    );
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
          '发布笔记',
          style: TextStyle(
            color: Color.fromRGBO(65, 53, 85, 1),
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _upload,
            child: const Text(
              '发布',
              style: TextStyle(
                color: Color.fromRGBO(141, 141, 141, 1),
                fontSize: 18,
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(5),
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
                onPressed: () {
                  _chooseCategory();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      category,
                      style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
                    ),
                    const Icon(
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
                controller: _textController,
                cursorColor: Colors.amber,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusColor: Color.fromRGBO(125, 122, 238, 1),
                  hintText: '请输入笔记标题（5-31个字）',
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
                controller: _vicetextController,
                cursorColor: Colors.amber,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusColor: Color.fromRGBO(125, 122, 238, 1),
                  hintText: '请输入副标题（展示封面的字体）',
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
                      style: const TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: Color.fromRGBO(0, 0, 0, 1),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: HtmlEditor(
                  controller: _controller,
                  htmlEditorOptions: const HtmlEditorOptions(
                    hint: '正文部分',
                    shouldEnsureVisible: true,
                  ),
                  htmlToolbarOptions: const HtmlToolbarOptions(
                      toolbarItemHeight: 30,
                      toolbarPosition: ToolbarPosition.aboveEditor,
                      defaultToolbarButtons: [
                        FontSettingButtons(
                            fontSizeUnit: false, fontName: false),
                        StyleButtons(),
                        ListButtons(listStyles: false),
                        ParagraphButtons(
                          textDirection: false,
                          lineHeight: false,
                          caseConverter: false,
                          decreaseIndent: false,
                        ),
                        InsertButtons(
                          video: false,
                          audio: false,
                          table: false,
                          hr: true,
                          otherFile: false,
                        ),
                      ]),
                  otherOptions: const OtherOptions(height: 800),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
