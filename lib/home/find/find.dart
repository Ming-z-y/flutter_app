import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../request/apis.dart';
import '../../utils/keepAliveWrapper.dart';
import 'generate.dart';

class Find extends StatefulWidget {
  const Find({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Find();
  }
}

class _Find extends State<Find> {
  List tabs = ["推荐"];
  late String tab_cur = "推荐";

  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    // _tabController = TabController(length: tabs.length, vsync: this);
    _getCagetory();
  }

  _getCagetory() {
    APIS.getCategory().then((value) {
      if (value.status == 10001) {
        setState(() {
          tabs = ['推荐', ...value.data!];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white, // appBar的背景颜色
          centerTitle: true,
          toolbarHeight: 40,
          title: TabBar(
            unselectedLabelColor: const Color.fromRGBO(94, 83, 109, 1),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
            labelColor: const Color.fromRGBO(41, 31, 54, 1),
            labelStyle: const TextStyle(fontWeight: FontWeight.w600),
            tabs: tabs.map((e) => Text(e)).toList(),
            isScrollable: true,
          ),
        ),
        body: TabBarView(
          children: tabs
              .map((e) => KeepAliveWrapper(
                      child: GenerateContent(
                    tab: e,
                  )))
              .toList(),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
    );
  }
}
