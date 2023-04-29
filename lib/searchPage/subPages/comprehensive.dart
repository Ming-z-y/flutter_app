import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/keepAliveWrapper.dart';

import '../generate.dart';

class Comprehensive extends StatefulWidget {
  final String searchKey;
  const Comprehensive({
    super.key,
    required this.searchKey,
  });

  @override
  State<Comprehensive> createState() => _ComprehensiveState();
}

class _ComprehensiveState extends State<Comprehensive> {
  List tabs = ["不限时间", "一天内", "一周内", "一月内", "三月内", "半年内"];
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
          elevation: 0,
          title: TabBar(
            indicator: BoxDecoration(
              color: Color.fromRGBO(236, 242, 254, 1),
              borderRadius: BorderRadius.circular(5),
            ),
            unselectedLabelColor: const Color.fromRGBO(94, 83, 109, 1),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w400,
            ),
            labelColor: const Color.fromRGBO(18, 108, 194, 1),
            tabs: tabs.map((e) => Text(e)).toList(),
            isScrollable: true,
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: tabs
              .map((e) => KeepAliveWrapper(
                  child: Generate(scope: 2, searchKey: widget.searchKey)))
              .toList(),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
    );
  }
}
