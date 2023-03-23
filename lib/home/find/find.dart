import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/cache.dart';
import '../../utils/keepAliveWrapper.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../../request/httpUtil.dart';
import '../../utils/refreshComponent.dart';

class Find extends StatefulWidget {
  const Find({super.key});

  @override
  State<Find> createState() {
    return _Find();
  }
}

class _Find extends State<Find> with SingleTickerProviderStateMixin {
  List tabs = ["推荐", "护肤", "发型", "健身", "穿搭", "美妆", "医美"];
  late String tab_cur = "推荐";
  Map<String, dynamic> contentMap = {
    "推荐": {"name": "初始化", "index": 1}
  };

  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      print('object');
    });
    tab_cur = "推荐";
  }

  Future<String> getData() async {
    var res = await HttpUtil.instance
        .get('/txtjson/classgroup/cgmw_all_editortj_1.txt');
    // print(data);
    return res;
  }

  void clickTabHandler(String title, int index) {
    if (contentMap[title] == null) {
      // 网络请求
      print('正在加载');
      // 模拟
      contentMap[title] = {"name": title, "index": index};
    } else
      // print('待使用');

      setState(() {
        tab_cur = title;
      });
  }

  Widget generate_content() {
    print(contentMap[tab_cur]["name"]);
    return ListView(
      children: [
        Text(contentMap[tab_cur]["name"]),
        // Text(contentMap[tab_cur]["index"])
      ],
    );
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
                    child: KeepAliveWrapper(child: Text(e)),
                  ))
              .toList(),
          onTap: (value) {
            clickTabHandler(tabs[value], value);
          },
        ),
      ),
      // body: TabBarView(
      //   controller: _tabController,
      //   children: generate_content(),
      // ),
      body: generate_content(),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
