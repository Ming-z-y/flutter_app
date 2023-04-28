import 'package:flutter/material.dart';
import 'package:flutter_application_1/login/components/form.dart';
import 'package:flutter_application_1/login/welcome.dart';
import 'package:flutter_application_1/request/apis.dart';
import 'package:flutter_application_1/request/httpUtil.dart';
import 'package:flutter_application_1/utils/checkForm.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Forget extends StatefulWidget {
  final String name;
  const Forget({super.key, required this.name});

  @override
  State<Forget> createState() {
    return _Forget();
  }
}

class _Forget extends State<Forget> {
  String checkForm(Map<String, String> data) {
    bool isFull = true;
    data.forEach((key, value) {
      if (value == "") isFull = false;
    });
    if (!isFull) return "表单未填写完整";
    if (CheckForm.checkPhone(data["phone"]!) != "ok") return "手机号不合规";
    if (data["pwd"] != data["pwd_again"]) return "两次填写密码不一致";
    return "ok";
  }

  submitForm(String name, Map<String, String> data) async {
    if (checkForm(data) != "ok") {
      return Fluttertoast.showToast(msg: checkForm(data));
    }

    if (name == "注册") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: ((BuildContext context) {
            return Welcome(
              phone: data['phone']!,
              pwd: data['pwd']!,
              code: data['code']!,
            );
          }),
        ),
      );
    }

    if (name == '忘记密码') {
      ResponseModal<Map<String, dynamic>> value =
          await APIS.resetPassword(data['phone']!, data['code']!, data['pwd']!);
      if (value.status == 10001) {
        Fluttertoast.showToast(msg: '重置密码成功');
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: '验证码不正确');
      }
    }

    // if (name == "注册") {
    //   var res =
    //       APIS.register(data["phone"]!, data["code"]!, data["pwd"]!, "Matthew");
    // }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() async {
        Forms.clearForm();
        return true;
      }),
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          toolbarHeight: 40,
          backgroundColor: Colors.white,
          title: Text(
            widget.name,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.black, //修改颜色
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(50),
          child: ListView(
            children: [
              Forms.getItem(),
              Forms.getItem(type: 'code'),
              Forms.getItem(type: 'pwd'),
              Forms.getItem(type: 'pwdAgain'),
              Forms.submitBtn(
                subFont: widget.name == "注册" ? "注册" : "重置密码",
                submit: (data) {
                  submitForm(widget.name, data);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
