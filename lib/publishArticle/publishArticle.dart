import 'package:flutter/material.dart';
import './components/articleEditor.dart';
import './components/videoEditor.dart';

class PublishArticle extends StatefulWidget {
  const PublishArticle({super.key});

  @override
  State<PublishArticle> createState() {
    return _PublishArticle();
  }
}

class _PublishArticle extends State<PublishArticle> {
  int _currentIndex = 0;
  List<Widget> lists = [const Article(), VideoEditor()];

  // 所有分区
  List<String> list = ['护肤', '发型', '健身', '穿搭', '美妆', '医美'];
  // 选择的分区名称
  String title = '选择分区';
  // 选择的index
  int chooseIndex = -1;

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
              onPressed: () {},
              child: const Text(
                '发布',
                style: TextStyle(
                  color: Color.fromRGBO(141, 141, 141, 1),
                  fontSize: 18,
                ),
              ))
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
                  showBottomSheet();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
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
              child: const TextField(
                cursorColor: Colors.amber,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusColor: Color.fromRGBO(125, 122, 238, 1),
                  hintText: '请输入笔记标题（5-31个字）',
                ),
              ),
            ),
            Container(
              child: lists[_currentIndex],
            ),
          ],
        ),
      ),
    );
  }

  // 浮出下面的选择框
  void showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: ((context) {
        return buildBottomSheetWidget(context);
      }),
    );
  }

  Widget buildBottomSheetWidget(BuildContext context) {
    int index = -1;
    //弹框中内容  310 的调试
    return SizedBox(
      height: 310,
      child: ListView(
        children: list.map((e) {
          index++;
          return bottomItem(e, index);
        }).toList(),
      ),
    );
  }

  // 定义每一个单选框选择
  Widget bottomItem(String title, int index) {
    IconData icon =
        index == chooseIndex ? Icons.circle_rounded : Icons.circle_outlined;
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pop();
          setState(() {
            chooseIndex = index;
            title = list[chooseIndex];
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color.fromRGBO(65, 53, 85, 1),
                fontSize: 20,
              ),
            ),
            Icon(
              icon,
              color: Color.fromRGBO(65, 53, 85, 1),
            )
          ],
        ),
      ),
    );
  }
}
