import 'package:flutter/material.dart';
import 'package:flutter_application_1/login/components/bottomText.dart';
import 'package:flutter_application_1/request/apis.dart';
import 'package:flutter_application_1/utils/cache.dart';
import 'package:flutter_application_1/utils/checkForm.dart';
import 'package:flutter_application_1/utils/showLoadingDialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../forgetAndRegister.dart';

class InputForm extends StatefulWidget {
  const InputForm({super.key});

  @override
  State<InputForm> createState() {
    return _InputForm();
  }
}

class _InputForm extends State<InputForm> {
  String type = 'code';
  static final TextEditingController _phone = TextEditingController();
  static final TextEditingController _code = TextEditingController();
  static final TextEditingController _pwd = TextEditingController();

  Map<String, String> getValue() {
    Map<String, String> res;
    if (type == 'code') {
      res = {"phone": _phone.text, "code": _code.text};
    } else {
      res = {"phone": _phone.text, "pwd": _pwd.text};
    }
    return res;
  }

  _handleLogin() async {
    Map<String, String> res = getValue();
    // ResponseModal<Map<String, dynamic>> data = ResponseModal.fromjson({});
    if (CheckForm.checkFormIsFull(res) != "ok") {
      return Fluttertoast.showToast(msg: "表单未填写完整");
    }
    if (CheckForm.checkPhone(res["phone"]!) != 'ok') {
      return Fluttertoast.showToast(msg: "手机号不合法");
    }
    if (!Bottom.isPoint) return Fluttertoast.showToast(msg: "未选中下方协议");

    if (type == 'code') {
      ResponseModal<Map<String, dynamic>> value =
          await APIS.loginByCode(res["phone"]!, res["code"]!);
      if (value.status == 10001) {
        showLoadingDialog(context);
        await AppCache.setToken(value.data!["access_token"]);
        await AppCache.setRefreshToken(value.data!["refresh_token"]);
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/home');
        // showLoadingDialog(context);
      } else {
        return Fluttertoast.showToast(msg: "手机号或者验证码不正确~");
      }
    } else {
      ResponseModal<Map<String, dynamic>> value =
          await APIS.loginByPassword(res["phone"]!, res["pwd"]!);
      if (value.status == 10001) {
        showLoadingDialog(context);
        await AppCache.setToken(value.data!["access_token"]);
        await AppCache.setRefreshToken(value.data!["refresh_token"]);
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/home');
        // showLoadingDialog(context);
      } else {
        return Fluttertoast.showToast(msg: "手机号或者密码不正确~");
      }
    }
  }

  getCode() {
    Map<String, String> res = getValue();
    if (CheckForm.checkPhone(res["phone"]!) != 'ok') {
      return Fluttertoast.showToast(msg: "手机号不合法");
    }
    APIS.getCode(res["phone"]!);
    return Fluttertoast.showToast(msg: "注意查收信息~");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 输入框
        type == 'code'
            ? Container(
                // height: 230,
                margin: const EdgeInsets.only(bottom: 60, top: 20),
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(215, 212, 247, 0.54),
                      offset: Offset(5.0, 15.0), //阴影xy轴偏移量
                      blurRadius: 25.0, //阴影模糊程度
                      spreadRadius: 2.0, //阴影扩散程度
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Stack(children: [
                        TextField(
                          controller: _phone,
                          cursorColor: Colors.white,
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.phone,
                            ),
                            focusColor: Color.fromRGBO(125, 122, 238, 1),
                            labelText: '手机号',
                          ),
                        ),
                        const Positioned(
                          right: 10,
                          top: 30,
                          child: Text(
                            '+86',
                            style: TextStyle(
                                color: Color.fromRGBO(153, 153, 153, 1),
                                fontSize: 16),
                          ),
                        )
                      ]),
                    ),
                    Container(
                      child: Stack(children: [
                        TextField(
                          controller: _code,
                          decoration: InputDecoration(
                            labelText: '验证码',
                            icon: Icon(Icons.lock),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 10,
                          child: TextButton(
                            onPressed: () {
                              getCode();
                            },
                            child: const Text(
                              '获取验证码',
                              style: TextStyle(
                                  color: Color.fromRGBO(153, 153, 153, 1),
                                  fontSize: 16),
                            ),
                          ),
                        )
                      ]),
                    ),
                    // 密码登录按钮
                    Container(
                      width: double.infinity,
                      child: Stack(
                        children: [
                          TextButton(
                            onPressed: (() {
                              setState(() {
                                type = 'phone';
                              });
                            }),
                            child: const Text(
                              '密码登录',
                              style: TextStyle(
                                  color: Color.fromRGBO(126, 124, 238, 1)),
                            ),
                          ),
                          Positioned(
                              right: 0,
                              child: TextButton(
                                onPressed: (() {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: ((BuildContext context) {
                                    return Forget(
                                      name: "注册",
                                    );
                                  })));
                                }),
                                child: const Text(
                                  '用户注册',
                                  style: TextStyle(
                                      color: Color.fromRGBO(126, 124, 238, 1)),
                                ),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              )
            : Container(
                // height: 230,
                margin: const EdgeInsets.only(bottom: 60, top: 20),
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(215, 212, 247, 0.54),
                      offset: Offset(5.0, 15.0), //阴影xy轴偏移量
                      blurRadius: 25.0, //阴影模糊程度
                      spreadRadius: 2.0, //阴影扩散程度
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Stack(children: [
                        TextField(
                          controller: _phone,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            icon: Icon(Icons.phone),
                            focusColor: Color.fromRGBO(125, 122, 238, 1),
                            labelText: '手机号',
                          ),
                        ),
                        Positioned(
                          right: 10,
                          top: 30,
                          child: Text(
                            '+86',
                            style: TextStyle(
                                color: Color.fromRGBO(153, 153, 153, 1),
                                fontSize: 16),
                          ),
                        )
                      ]),
                    ),
                    TextField(
                      obscureText: true,
                      controller: _pwd,
                      decoration: InputDecoration(
                        labelText: '密码',
                        icon: Icon(Icons.lock),
                      ),
                    ),
                    // 密码登录按钮
                    Container(
                      width: double.infinity,
                      child: Stack(children: [
                        TextButton(
                          onPressed: (() {
                            setState(() {
                              type = 'code';
                            });
                          }),
                          child: const Text(
                            '免密登录',
                            style: TextStyle(
                                color: Color.fromRGBO(126, 124, 238, 1)),
                          ),
                        ),
                        Positioned(
                          left: 70,
                          child: TextButton(
                            onPressed: (() {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((BuildContext context) {
                                return Forget(
                                  name: "忘记密码",
                                );
                              })));
                            }),
                            child: const Text(
                              '忘记密码',
                              style: TextStyle(
                                  color: Color.fromRGBO(126, 124, 238, 1)),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: TextButton(
                            onPressed: (() {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((BuildContext context) {
                                return Forget(
                                  name: "注册",
                                );
                              })));
                            }),
                            child: const Text(
                              '用户注册',
                              style: TextStyle(
                                  color: Color.fromRGBO(126, 124, 238, 1)),
                            ),
                          ),
                        )
                      ]),
                    )
                  ],
                ),
              ),

        // 登录按钮
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromRGBO(128, 125, 239, 1)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            onPressed: () {
              _handleLogin();
            },
            child: const Text("登录"),
          ),
        ),
      ],
    );
  }
}
