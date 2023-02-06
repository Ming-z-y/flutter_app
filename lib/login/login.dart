import 'package:flutter/material.dart';
import './components/inputForm.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> {
  bool hasChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.only(left: 35, top: 50, right: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // top的标题
              SizedBox(
                width: double.infinity,
                height: 100,
                child: Stack(
                  children: const [
                    Positioned(
                      left: 0,
                      child: Text(
                        "Hello~",
                        style: TextStyle(
                          color: Color.fromRGBO(90, 81, 144, 1),
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 50,
                      child: Text(
                        "欢迎来到男生日记",
                        style: TextStyle(
                          color: Color.fromRGBO(90, 81, 144, 1),
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // inputForm 表单
              const InputForm(),
              // 下面的文字
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 30),
                child: Stack(children: [
                  Checkbox(
                    value: hasChecked,
                    activeColor: const Color.fromRGBO(128, 125, 239, 1),
                    onChanged: (value) {
                      setState(() {
                        hasChecked = value!;
                      });
                    },
                  ),
                  const Positioned(
                    left: 38,
                    top: 15,
                    child: Text(
                      "登录即代表您已阅读并同意《用户协议》和《隐私政策》",
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  )
                ]),
              )
            ],
          )),
    );
  }
}
