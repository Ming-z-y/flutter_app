import 'package:flutter/material.dart';
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
  }

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
      body: const Main_Content(),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
