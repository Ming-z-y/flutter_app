import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/home/find/find.dart';
import 'package:flutter_application_1/request/dio.dart';
import '../searchPage/search.dart';
import './hot/hot.dart';
import '../request/httpUtil.dart';
import 'package:http/http.dart' as http;

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
    print('************');
    var data = getData();
    print(data);
  }

  getData() async {
    // BaseOptions baseOptions = BaseOptions(baseUrl: 'http://www.duwenz.com');
    // Dio dio = new Dio(baseOptions);
    // Response data =
    //     await dio.get('/txtjson/classgroup/cgmw_all_editortj_1.txt');
    // print(data);
    // return data;
    // Response data = await Dio().get(
    //     'http://www.duwenz.com/txtjson/classgroup/cgmw_all_editortj_1.txt');
    // print(data.data);
    // return data;
    var data =
        await HttpUtil().get('/txtjson/classgroup/cgmw_all_editortj_1.txt');
    print(data);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // appBar的背景颜色
        centerTitle: true,
        toolbarHeight: 40,
        elevation: 0, // 去掉Appbar底部阴影
        title: Row(
          children: [
            Expanded(
              flex: 2,
              child: TextButton(
                child: Text('每日一答'),
                onPressed: () {},
              ),
            ),
            const Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Expanded(
              flex: 6,
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
                  ]),
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
      body: TabBarView(controller: _tabController, children: const [
        Find(),
        Hot(),
      ]),
    );
  }
}
