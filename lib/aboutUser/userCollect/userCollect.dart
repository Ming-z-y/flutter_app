import 'package:flutter/material.dart';
import 'package:bruno/bruno.dart';

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
            print(index);
          },
        ),
        ListView(
          shrinkWrap: true, //范围内进行包裹（内容多高ListView就多高）
          // physics: NeverScrollableScrollPhysics(), //禁止滚动
          children: const [
            Text('das'),
          ],
        )
      ],
    );
  }
}
