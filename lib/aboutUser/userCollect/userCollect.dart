import 'package:flutter/material.dart';
import 'package:bruno/bruno.dart';
import 'package:flutter_application_1/aboutUser/userCollect/bump.dart';
import 'package:flutter_application_1/aboutUser/userCollect/collect.dart';
import 'package:flutter_application_1/aboutUser/userCollect/works.dart';
import 'package:flutter_application_1/utils/keepAliveWrapper.dart';

class UserCollect extends StatefulWidget {
  const UserCollect({super.key});

  @override
  _UserCollect createState() {
    // TODO: implement createState
    return _UserCollect();
  }
}

class _UserCollect extends State<UserCollect> with TickerProviderStateMixin {
  late TabController tabController;
  late List<BadgeTab> tabs;
  int _index = 0;
  List<Widget> content = [
    KeepAliveWrapper(child: Works()),
    KeepAliveWrapper(child: Collects()),
    KeepAliveWrapper(child: Bumps()),
  ];
  @override
  void initState() {
    tabs = [BadgeTab(text: "作品"), BadgeTab(text: "收藏"), BadgeTab(text: "点赞")];
    // final List list = ["作品", "收藏", "点赞"];
    tabController = TabController(length: tabs.length, vsync: this);

    // int index = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BrnTabBar(
          tabs: tabs,
          controller: tabController,
          onTap: (state, index) {
            setState(() {
              _index = index;
            });
          },
        ),
        content[_index]
      ],
    );
  }
}
