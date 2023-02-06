import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import '../forget.dart';

class InputForm extends StatefulWidget {
  const InputForm({super.key});

  @override
  State<InputForm> createState() {
    return _InputForm();
  }
}

class _InputForm extends State<InputForm> {
  String type = 'code';

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
                  color: Colors.amber,
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
                      child: Stack(children: const [
                        TextField(
                          cursorColor: Colors.amber,
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
                    Container(
                      child: Stack(children: [
                        const TextField(
                          decoration: InputDecoration(
                            labelText: '验证码',
                            icon: Icon(Icons.add_box_rounded),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 10,
                          child: TextButton(
                            onPressed: () {},
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
                                onPressed: (() {}),
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
                  color: Colors.amber,
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
                      child: Stack(children: const [
                        TextField(
                          cursorColor: Colors.amber,
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
                    const TextField(
                      decoration: InputDecoration(
                        labelText: '密码',
                        icon: Icon(Icons.add_box_rounded),
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
                                return Forget();
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
                            onPressed: (() {}),
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
              Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
                return const Rooter();
              })));
            },
            child: const Text("登录"),
          ),
        ),
      ],
    );
  }
}
