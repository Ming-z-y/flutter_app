import 'package:flutter/material.dart';

class Find extends StatefulWidget {
  const Find({super.key});

  @override
  State<Find> createState() {
    return _Find();
  }
}

class _Find extends State<Find> with SingleTickerProviderStateMixin {
  var tabs = ["推荐", "护肤", "发型", "健身", "穿搭", "美妆", "医美"];
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: Colors.white,
        elevation: 0, // 去掉tabBar的阴影
        title: TabBar(
            indicatorColor: Colors.white,
            isScrollable: true,
            labelColor: Colors.black,
            labelStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            unselectedLabelColor: Colors.black38,
            controller: _tabController,
            tabs: tabs
                .map((e) => Tab(
                      child: Text(e),
                    ))
                .toList()),
      ),
      body: TabBarView(
        controller: _tabController,
        children: tabs.map((e) => Text(e)).toList(),
      ),
    );
  }
}
