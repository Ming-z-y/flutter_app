import 'package:flutter/material.dart';

class BottomText extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Bottom();
  }
}

class Bottom extends State<BottomText> {
  static bool isPoint = false;
  @override
  void initState() {
    isPoint = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 30),
      child: Row(children: [
        Checkbox(
          value: isPoint,
          activeColor: const Color.fromRGBO(128, 125, 239, 1),
          onChanged: (value) {
            setState(() {
              isPoint = value!;
            });
          },
        ),
        const Expanded(
            child: Text(
          "登录即代表您已阅读并同意《用户协议》和《隐私政策》",
          style: TextStyle(fontSize: 12, color: Colors.black54),
        ))
      ]),
    );
  }
}
