import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MessagePage();
  }
}

class _MessagePage extends State<MessagePage> {
  List items = ["点赞", "收藏", "评论", "粉丝"];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FlutterEasyLoading(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 40,
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Color.fromRGBO(65, 53, 85, 1),
          ),
          title: const Text(
            '消息',
            style: TextStyle(
              color: Color.fromRGBO(65, 53, 85, 1),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: EasyRefresh(
            child: CustomScrollView(
          slivers: [
            SliverGrid.count(
              crossAxisCount: 4,
              children: List.generate(4, (index) {
                return Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 50,
                          height: 40,
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(217, 217, 217, 1)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          items[index],
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ));
              }).toList(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((content, index) {
                return Container(
                  height: 85,
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: ListTile(
                    title: Text('消息通知: $index'),
                    leading: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(217, 217, 217, 1),
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                    ),
                    subtitle: const Text('xxxxxxxxxxxxxxxxxxx'),
                    trailing: Column(children: [
                      const Text('昨天'),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 18,
                        height: 18,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(255, 90, 90, 1),
                          borderRadius: BorderRadius.all(Radius.circular(9.0)),
                        ),
                        child: Center(
                            child: Text(
                          index.toString(),
                          style: TextStyle(color: Colors.white),
                        )),
                      )
                    ]),
                  ),
                );
              }, childCount: 10),
            )
          ],
        )),
      ),
    );
  }
}
