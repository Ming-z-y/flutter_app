import 'package:flutter/material.dart';

class Forget extends StatefulWidget {
  const Forget({super.key});

  @override
  State<Forget> createState() {
    return _Forget();
  }
}

class _Forget extends State<Forget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 40,
        backgroundColor: Colors.white,
        title: const Text(
          '忘记密码',
          style: TextStyle(
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
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10, bottom: 5, right: 10),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 206, 221, 237),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: const TextField(
                cursorColor: Color.fromRGBO(125, 122, 238, 1),
                decoration: InputDecoration(
                  icon: Icon(Icons.phone),
                  focusColor: Color.fromRGBO(125, 122, 238, 1),
                  hintText: '请输入您的手机号',
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.only(left: 10, bottom: 5, right: 10),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 206, 221, 237),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Stack(
                  children: [
                    const TextField(
                      cursorColor: Color.fromRGBO(125, 122, 238, 1),
                      decoration: InputDecoration(
                        icon: Icon(Icons.add_box),
                        focusColor: Color.fromRGBO(125, 122, 238, 1),
                        hintText: '请输入验证码',
                        border: InputBorder.none,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          '获取验证码',
                          style: TextStyle(
                            color: Color.fromRGBO(125, 122, 238, 1),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 50),
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
                onPressed: () {},
                child: const Text("重置密码"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
