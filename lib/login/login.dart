import 'package:flutter/material.dart';
import 'package:flutter_application_1/login/components/bottomText.dart';
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).backgroundColor,
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
                      "欢迎来到魅力榜样",
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
            const InputForm(),
            Expanded(
              child: BottomText(),
            ),
            // 下面的文字
          ],
        ),
      ),
    );
  }
}
