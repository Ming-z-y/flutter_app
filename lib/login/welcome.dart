import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/request/apis.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/cache.dart';
import '../utils/showLoadingDialog.dart';

class Welcome extends StatefulWidget {
  final String phone;
  final String code;
  final String pwd;

  const Welcome({
    super.key,
    required this.phone,
    required this.code,
    required this.pwd,
  });
  @override
  State<StatefulWidget> createState() => _Welcome();
}

class _Welcome extends State<Welcome> {
  final TextEditingController _controller = TextEditingController();

  _solve() async {
    if (_controller.text == '') return Fluttertoast.showToast(msg: '未输入完整');
    ResponseModal<Map<String, dynamic>> value = await APIS.register(
        widget.phone, widget.code, widget.pwd, _controller.text);
    print(value.status);
    print(value.info);
    print(value.data);
    if (value.status == 10001) {
      showLoadingDialog(context);
      await AppCache.setToken(value.data!["access_token"]);
      await AppCache.setRefreshToken(value.data!["refresh_token"]);
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      return Fluttertoast.showToast(msg: "检查一下填写信息是否正确~");
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 40,
        backgroundColor: Colors.white,
        title: const Text(''),
        iconTheme: const IconThemeData(
          color: Colors.black, //修改颜色
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 50, right: 50),
        child: Column(
          children: [
            SizedBox(height: 50),
            Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image/avatar.jpg'),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: const EdgeInsets.only(left: 10, bottom: 5, right: 10),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(241, 245, 249, 0.8),
                borderRadius: BorderRadius.all(
                  Radius.circular(60),
                ),
              ),
              child: TextField(
                controller: _controller,
                cursorColor: Colors.amber,
                decoration: const InputDecoration(
                  icon: Icon(Icons.account_circle_rounded),
                  focusColor: Colors.amber,
                  hintText: '请输入您的用户名',
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 30),
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
                  _solve();
                },
                child: const Text('欢迎加入我们'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
