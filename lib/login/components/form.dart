import 'package:flutter/material.dart';
import 'package:flutter_application_1/request/apis.dart';
import 'package:flutter_application_1/utils/checkForm.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Forms {
  static Color bgc = const Color.fromRGBO(241, 245, 249, 0.8);
  static Color inputColor = const Color.fromRGBO(125, 122, 238, 1);
  static double radius = 20;
  static String type = 'phone';
  static final TextEditingController _phone = TextEditingController();
  static final TextEditingController _code = TextEditingController();
  static final TextEditingController _pwd = TextEditingController();
  static final TextEditingController _pwdAgain = TextEditingController();

  static getCode() {
    if (CheckForm.checkPhone(_phone.text) != "ok")
      return Fluttertoast.showToast(msg: "手机号不合规");
    APIS.getCode(_phone.text);
    Fluttertoast.showToast(msg: "请注意查收手机验证码~");
  }

  static Widget codeBtn({double marginTop = 20}) {
    return Container(
      margin: EdgeInsets.only(top: marginTop),
      padding: const EdgeInsets.only(left: 10, bottom: 5, right: 10),
      decoration: BoxDecoration(
        color: bgc,
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
      ),
      child: Stack(
        children: [
          TextField(
            controller: _code,
            cursorColor: inputColor,
            decoration: InputDecoration(
              icon: const Icon(Icons.lock),
              focusColor: inputColor,
              hintText: '请输入验证码',
              border: InputBorder.none,
            ),
          ),
          Positioned(
            right: 0,
            child: TextButton(
              onPressed: () {
                getCode();
              },
              child: Text(
                '获取验证码',
                style: TextStyle(
                  color: inputColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  static void clearForm() {
    _code.clear();
    _phone.clear();
    _pwd.clear();
    _pwdAgain.clear();
  }

  static Widget phoneBtn({double marginTop = 0}) {
    return Container(
      margin: EdgeInsets.only(top: marginTop),
      padding: const EdgeInsets.only(left: 10, bottom: 5, right: 10),
      decoration: BoxDecoration(
          color: bgc, borderRadius: BorderRadius.all(Radius.circular(radius))),
      child: TextField(
        controller: _phone,
        cursorColor: inputColor,
        decoration: InputDecoration(
          icon: const Icon(Icons.phone),
          focusColor: inputColor,
          hintText: '请输入您的手机号',
          border: InputBorder.none,
        ),
      ),
    );
  }

  static Widget pwdBtn({double marginTop = 20}) {
    return Container(
      margin: EdgeInsets.only(top: marginTop),
      padding: const EdgeInsets.only(left: 10, bottom: 5, right: 10),
      decoration: BoxDecoration(
        color: bgc,
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
      ),
      child: TextField(
        obscureText: true,
        controller: _pwd,
        cursorColor: inputColor,
        decoration: InputDecoration(
          icon: const Icon(Icons.add_box),
          focusColor: inputColor,
          hintText: '请输入密码',
          border: InputBorder.none,
        ),
      ),
    );
  }

  static Widget pwdAgainBtn({double marginTop = 20}) {
    return Container(
      margin: EdgeInsets.only(top: marginTop),
      padding: const EdgeInsets.only(left: 10, bottom: 5, right: 10),
      decoration: BoxDecoration(
        color: bgc,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: TextField(
        obscureText: true,
        controller: _pwdAgain,
        cursorColor: inputColor,
        decoration: InputDecoration(
          icon: Icon(Icons.add_box),
          focusColor: inputColor,
          hintText: '请再次输入您的密码',
          border: InputBorder.none,
        ),
      ),
    );
  }

  static Widget submitBtn(
      {String subFont = "重置密码",
      required Function(Map<String, String> data) submit}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 50),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(const Color.fromRGBO(128, 125, 239, 1)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        onPressed: () {
          Map<String, String> data = {
            "phone": _phone.text,
            "code": _code.text,
            "pwd": _pwd.text,
            "pwd_again": _pwdAgain.text
          };
          submit(data);
        },
        child: Text(subFont),
      ),
    );
  }

  static Widget getItem({String type = 'phone'}) {
    if (type == 'phone') {
      return phoneBtn();
    } else if (type == 'code') {
      return codeBtn();
    } else if (type == 'pwd') {
      return pwdBtn();
    } else if (type == 'pwdAgain') {
      return pwdAgainBtn();
    }
    return phoneBtn();
  }
}
