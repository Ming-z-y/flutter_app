import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/searchPage/subPages/comprehensive.dart';
import 'package:flutter_application_1/searchPage/subPages/current.dart';
import '../utils/keepAliveWrapper.dart';

import './subPages/user.dart';

class SearchResult extends StatefulWidget {
  final String searchKey;
  const SearchResult({
    super.key,
    required this.searchKey,
  });

  @override
  State<SearchResult> createState() {
    return _SearchResult();
  }
}

class _SearchResult extends State<SearchResult> {
  String searchKey = '';
  List tabs = ['综合', '实时', '用户'];
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    setState(() {
      searchKey = widget.searchKey;
      _controller.text = searchKey;
    });
    super.initState();
  }

  _onSubmitted(String value) {
    if (value != searchKey) {
      setState(() {
        searchKey = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 50,
          iconTheme:
              const IconThemeData(color: Color.fromRGBO(125, 122, 238, 1)),
          title: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.center,
                      height: 30,
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(246, 246, 246, 1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: TextField(
                        controller: _controller,
                        cursorColor: Colors.amber,
                        onSubmitted: _onSubmitted,
                        style: const TextStyle(fontSize: 15),
                        decoration: const InputDecoration(
                          icon: Icon(Icons.search),
                          focusColor: Color.fromRGBO(125, 122, 238, 1),
                          hintText: '搜索的东西',
                          border: InputBorder.none,
                          isCollapsed: true,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 50)
                ],
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: TabBar(
                unselectedLabelColor: const Color.fromRGBO(94, 83, 109, 1),
                unselectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.w400),
                labelColor: const Color.fromRGBO(41, 31, 54, 1),
                labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                tabs: tabs.map((e) => Text(e)).toList(),
                isScrollable: true,
                indicator: const BoxDecoration(),
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  KeepAliveWrapper(child: Comprehensive(searchKey: searchKey)),
                  KeepAliveWrapper(
                    child: Current(
                      searchKey: searchKey,
                    ),
                  ),
                  KeepAliveWrapper(
                    child: User(
                      searchKey: searchKey,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
    );
  }
}
