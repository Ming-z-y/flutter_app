import 'package:flutter/material.dart';
import 'package:flutter_application_1/request/apis.dart';

class ChooseTitle {
  static late String title;
  static setTitle(String t) {
    title = t;
  }
}

Future<String?> chooseCategory({required BuildContext context}) async {
  List<dynamic> list = (await APIS.getCategory()).data ?? [];
  await showModalBottomSheet<String>(
    context: context,
    builder: (context) {
      return SizedBox(
        height: (50 * list.length).toDouble(),
        child: ListView(
          children: list.map((e) {
            return buildItem(
                title: e, context: context, onTap: ChooseTitle.setTitle);
          }).toList(),
        ),
      );
    },
  );
  return ChooseTitle.title;
}

Widget buildItem(
    {required String title,
    Function(String t)? onTap,
    required BuildContext context}) {
  //添加点击事件
  return InkWell(
    //点击回调
    onTap: () {
      //关闭弹框
      Navigator.of(context).pop();
      //外部回调
      if (onTap != null) {
        onTap(title);
      }
    },
    child: Container(
      height: 40,
      //左右排开的线性布局
      child: Row(
        //所有的子Widget 水平方向居中
        mainAxisAlignment: MainAxisAlignment.center,
        //所有的子Widget 竖直方向居中
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Text(title)],
      ),
    ),
  );
}
