import 'package:flutter/material.dart';
import 'package:flutter_application_1/attention/focusItem.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../request/apis.dart';
import '../../utils/keepAliveWrapper.dart';
import 'generate.dart';

class Main_Content extends StatefulWidget {
  const Main_Content({super.key});

  @override
  State<StatefulWidget> createState() => _Main_Content();
}

class _Main_Content extends State<Main_Content> {
  List tabs = [];
  bool isEmpty = false;
  @override
  void initState() {
    _getFocus();
    super.initState();
  }

  _getFocus() {
    APIS.getFocus(0).then((value) {
      if (value.status == 10001) {
        if (value.data["get_focuses"] != null) {
          setState(() {
            tabs = value.data["get_focuses"];
          });
        } else if (value.data["get_focuses"] == null || tabs.isEmpty) {
          setState(() {
            isEmpty = true;
          });
        }
      }
    });
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 2000), () {
      _getFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _onRefresh,
        child: DefaultTabController(
          length: tabs.length + 1,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white, // appBar的背景颜色
              centerTitle: true,
              toolbarHeight: 100,
              elevation: 0,
              title: Container(
                alignment: Alignment.topLeft,
                child: TabBar(
                  indicator: const BoxDecoration(),
                  unselectedLabelColor: const Color.fromRGBO(94, 83, 109, 1),
                  unselectedLabelStyle:
                      const TextStyle(fontWeight: FontWeight.w400),
                  labelColor: const Color.fromRGBO(41, 31, 54, 1),
                  labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                  tabs: [
                    const FocusItem(
                      isFull: true,
                      user_id: 1,
                      avatar: '2',
                      nick_name: '1',
                    ),
                    ...tabs
                        .map(
                          (item) => FocusItem(
                            isFull: false,
                            user_id: item['id'] ?? 0,
                            avatar: item['avatar'] ?? '',
                            nick_name: item['nick_name'] ?? '',
                          ),
                        )
                        .toList()
                  ],
                  isScrollable: true,
                ),
              ),
            ),
            body: tabs.isNotEmpty
                ? TabBarView(children: [
                    KeepAliveWrapper(
                      child: GenerateContent(
                        isFull: true,
                        user_id: 1,
                        onRefresh: _getFocus,
                      ),
                    ),
                    ...tabs
                        .map(
                          (item) => KeepAliveWrapper(
                            child: GenerateContent(
                              isFull: false,
                              user_id: item['id'],
                              onRefresh: _getFocus,
                            ),
                          ),
                        )
                        .toList(),
                  ])
                : isEmpty
                    ? ListView(
                        children: const [
                          Center(
                            child: Text('还没有关注人哦~'),
                          )
                        ],
                      )
                    : const SpinKitPouringHourGlass(
                        color: Color.fromRGBO(138, 135, 240, 1),
                      ),
            backgroundColor: Theme.of(context).backgroundColor,
          ),
        ));
  }
}
