import 'package:flutter/material.dart';

Future queryIsChecked(
    {required BuildContext context, required Function() onOk}) async {
  var res = await showDialog<bool>(
      context: context,
      builder: ((context) {
        return AlertDialog(
          // title: Text('确定'),
          content: Text('确定要发布吗'),
          actions: [
            TextButton(
              onPressed: (() {
                Navigator.pop(context);
              }),
              child: Text('取消'),
            ),
            TextButton(
                onPressed: (() {
                  Navigator.pop(context);
                  onOk();
                }),
                child: Text('确定'))
          ],
        );
      }));
  return res;
}
