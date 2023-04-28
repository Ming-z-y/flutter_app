import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/message/pages/fansMessage.dart';
import 'package:flutter_application_1/request/apis.dart';
import 'package:flutter_application_1/utils/eventBus.dart';
import '../request/websoctetApis.dart';
import 'pages/bumpedMessage.dart';
import 'pages/collectMessage.dart';
import 'pages/commentMessage.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MessagePage();
  }
}

class _MessagePage extends State<MessagePage> {
  List newData = [];
  List oldData = [];
  List messageNum = [0, 0, 0, 0];

  @override
  void initState() {
    WebSocketChannel.instance.connect();
    super.initState();
    _getOldMessage();
    List messageStack = [0, 0, 0, 0];
    WebSocketChannel.instance.addListener(() {
      setState(() {
        newData = WebSocketChannel.newData;
        // 发布消息
        if (newData.isNotEmpty) {
          EventBusUtils.getInstance().fire(EventBus_data(newData.length));
        }
        newData.forEach((element) {
          if (element['typ'] == 2) {
            messageStack[0]++;
          }
          if (element['typ'] == 3) {
            messageStack[3]++;
          }
          if (element['typ'] == 4) {
            messageStack[1]++;
          }
          if (element['typ'] == 5) {
            messageStack[2]++;
          }
        });
      });
    });
    setState(() {
      messageNum = messageStack;
    });
  }

  _getOldMessage() {
    APIS.getOldMessage().then((value) {
      if (value.status == 10001) {
        setState(() {
          oldData = value.data!;
        });
      }
    });
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 2000), () {
      _getOldMessage();
    });
  }

  List items = ["点赞", "收藏", "评论", "粉丝"];

  _onChange(index, n) {
    if (messageNum[index] != n) {
      setState(() {
        messageNum[index] = n;
      });
    }
    // 清空消息页面
    if (messageNum == [0, 0, 0, 0]) {
      EventBusUtils.getInstance().fire(EventBus_data(0));
    }
  }

  _navToDetail(int index) {
    if (index == 3) {
      Navigator.of(context).push(
        MaterialPageRoute(
          //没有传值
          builder: (context) => FansMessage(
            oldMessage:
                oldData.where((element) => element['typ'] == 3).toList(),
            newMessage:
                newData.where((element) => element['typ'] == 3).toList(),
            onChange: _onChange,
          ),
        ),
      );
    } else if (index == 1) {
      Navigator.of(context).push(
        MaterialPageRoute(
          //没有传值
          builder: (context) => CollectMessage(
            oldMessage:
                oldData.where((element) => element['typ'] == 4).toList(),
            newMessage:
                newData.where((element) => element['typ'] == 4).toList(),
            onChange: _onChange,
          ),
        ),
      );
    } else if (index == 0) {
      Navigator.of(context).push(
        MaterialPageRoute(
          //没有传值
          builder: (context) => BumpedMessage(
            oldMessage:
                oldData.where((element) => element['typ'] == 2).toList(),
            newMessage:
                newData.where((element) => element['typ'] == 2).toList(),
            onChange: _onChange,
          ),
        ),
      );
    } else if (index == 2) {
      Navigator.of(context).push(
        MaterialPageRoute(
          //没有传值
          builder: (context) => CommentMessage(
            oldMessage:
                oldData.where((element) => element['typ'] == 5).toList(),
            newMessage:
                newData.where((element) => element['typ'] == 5).toList(),
            onChange: _onChange,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: CustomScrollView(
          slivers: [
            SliverGrid.count(
              crossAxisCount: 4,
              children: List.generate(
                4,
                (index) {
                  return InkWell(
                    onTap: (() {
                      _navToDetail(index);
                    }),
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 30, bottom: 25),
                            width: 50,
                            height: 40,
                            decoration: BoxDecoration(
                              // color: Color.fromRGBO(217, 217, 217, 1),
                              image: index == 1
                                  ? const DecorationImage(
                                      image: AssetImage('assets/image/lc.jpg'))
                                  : index == 2
                                      ? const DecorationImage(
                                          image:
                                              AssetImage('assets/image/pl.jpg'))
                                      : index == 3
                                          ? const DecorationImage(
                                              image: AssetImage(
                                                  'assets/image/fs.jpg'))
                                          : const DecorationImage(
                                              image: AssetImage(
                                                  'assets/image/dz.jpg')),
                            ),
                            child: messageNum[index] != 0
                                ? Center(
                                    child: Container(
                                      alignment: Alignment.topCenter,
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                      ),
                                      child: Text(
                                        messageNum[index].toString(),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 7.2),
                                      ),
                                    ),
                                  )
                                : Container(),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            items[index],
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((content, index) {
                return Container();
              }, childCount: 10),
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
