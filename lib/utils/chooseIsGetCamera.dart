import 'package:flutter/material.dart';

class ChooseMethod {
  static int isGetCamera = 0;
  static setIsGetCamera(int t) {
    isGetCamera = t;
  }
}

Future<int?> chooseIsGetCamera({required BuildContext context}) async {
  List<String> list = ['拍照', '从相册中选取'];
  await showModalBottomSheet<String>(
    context: context,
    builder: (context) {
      return SizedBox(
        height: 170,
        child: ListView(
          children: list.map((e) {
            return buildItem(
                title: e, context: context, onTap: ChooseMethod.setIsGetCamera);
          }).toList(),
        ),
      );
    },
  );
  return ChooseMethod.isGetCamera;
}

Widget buildItem({
  required String title,
  Function(int t)? onTap,
  required BuildContext context,
}) {
  //添加点击事件
  return InkWell(
    //点击回调
    onTap: () {
      //关闭弹框
      Navigator.of(context).pop();
      //外部回调
      if (onTap != null) {
        if (title == '拍照')
          onTap(1);
        else if (title == '从相册中选取') onTap(2);
      }
      // ChooseMethod.setIsGetCamera(0);
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
