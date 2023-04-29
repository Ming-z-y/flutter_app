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
  return InkWell(
    onTap: () {
      Navigator.of(context).pop();
      if (onTap != null) {
        onTap(title);
      }
    },
    child: Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Text(title)],
      ),
    ),
  );
}
