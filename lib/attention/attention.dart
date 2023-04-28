import 'package:flutter/material.dart';
import 'package:flutter_application_1/request/apis.dart';
import '../components/articleItem.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../utils/refreshComponent.dart';
import 'main_content.dart';

class Attention extends StatefulWidget {
  const Attention({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Attention();
  }
}

class _Attention extends State<Attention> {
  var focus_userdata = {};
  @override
  void initState() {
    super.initState();
    // get_focus_user();
    // get_focus_work();
  }

  // void get_focus_user() {
  //   APIS.getFocus(0).then((value) {
  //     setState(() {
  //       focus_userdata = value.data;
  //     });
  //   });
  // }

  // void get_focus_work() {
  //   APIS.getFocusWork(0).then((value) {
  //     print(value.info);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 40,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(65, 53, 85, 1),
        ),
        title: const Text(
          '关注',
          style: TextStyle(
            color: Color.fromRGBO(65, 53, 85, 1),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Main_Content(),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
