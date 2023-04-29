import 'package:flutter/material.dart';
import 'package:flutter_application_1/home/find/find.dart';
import '../searchPage/search.dart';
import './hot/hot.dart';
import '../utils/keepAliveWrapper.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() {
    return _Home();
  }
}

class _Home extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white, // appBar的背景颜色
        centerTitle: true,
        toolbarHeight: 40,
        elevation: 0, // 去掉Appbar底部阴影
        titleSpacing: 0,
        title: Row(
          children: [
            Expanded(
              flex: 4,
              child: TextButton(
                child: Text('每日一答'),
                onPressed: () {},
              ),
            ),
            const Expanded(
              flex: 2,
              child: SizedBox(),
            ),
            Expanded(
              flex: 10,
              child: TabBar(
                isScrollable: true, // tabs是否可以滚动
                indicatorColor: Colors.white, // 指示器的颜色
                controller: _tabController,
                labelColor: Colors.black, // label的颜色
                labelStyle: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w800), // label的样式
                unselectedLabelColor: Colors.black38, // 设置没有选中的label的颜色
                tabs: const [
                  Tab(
                    child: Text("发现"),
                  ),
                  Tab(
                    child: Text("热榜"),
                  ),
                ],
              ),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: ((context) {
                  return const SearchPage();
                })));
              },
              icon: const Icon(
                Icons.search,
                color: Colors.black38,
              ))
        ],
      ),
      body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: const [
            KeepAliveWrapper(child: Find()),
            KeepAliveWrapper(child: Hot()),
          ]),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
