import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:file_picker/file_picker.dart';

class Article extends StatefulWidget {
  const Article({super.key});

  @override
  State<Article> createState() {
    // TODO: implement createState
    return _Article();
  }
}

class _Article extends State<Article> {
  final HtmlEditorController _controller = HtmlEditorController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: Column(
      children: [
        HtmlEditor(
          controller: _controller,
          htmlEditorOptions: const HtmlEditorOptions(
            hint: '正文部分',
            shouldEnsureVisible: true,
            customOptions: '''
             toolbar: [
             ['style', ['style']],
             ['font', ['bold', 'underline', 'clear']],
             ['fontname', ['fontname']],
             ['color', ['color']],
             ['para', ['ul', 'ol', 'paragraph']],
             ['table', ['table']],
             ['insert', ['link', 'picture', 'video']],
             ['view', ['fullscreen', 'codeview', 'help']],
          ],
         ''',
          ),
          htmlToolbarOptions: const HtmlToolbarOptions(
            toolbarItemHeight: 30,
            toolbarPosition: ToolbarPosition.aboveEditor,
          ),
        ),
        TextButton(
          onPressed: (() {
            _controller.getText().then((value) {
              print(value);
            });
          }),
          child: Text('获取'),
        )
      ],
    ));
  }
}
