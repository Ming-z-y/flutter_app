import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../aboutUser/user.dart';

class FansMessage extends StatefulWidget {
  final List oldMessage;
  final List newMessage;
  final Function(int index, int num) onChange;
  const FansMessage({
    super.key,
    required this.oldMessage,
    required this.newMessage,
    required this.onChange,
  });

  @override
  State<FansMessage> createState() => _FansMessageState();
}

class _FansMessageState extends State<FansMessage> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 5), () async {
      widget.onChange(3, widget.newMessage.length);
    });
    super.initState();
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
          '新增关注',
          style: TextStyle(
            color: Color.fromRGBO(65, 53, 85, 1),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        children: [
          ...widget.newMessage
              .map(
                (item) => Container(
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => User(
                                      user_id:
                                          item['payload']['user_id'].toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Container(
                                    width: 39,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(16.0)),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: item['payload']['avatar'],
                                      errorWidget: (context, url, error) {
                                        return Text('出错了');
                                      },
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              LinearProgressIndicator(
                                        value: downloadProgress.progress,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        item['payload']['nick_name'],
                                        style: TextStyle(fontSize: 13),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        '开始关注了你  ${item['payload']['at_time']}',
                                        style: TextStyle(
                                            fontSize: 8,
                                            color: Color.fromRGBO(
                                                125, 125, 125, 1)),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            // Container(
                            //   height: 35,
                            //   decoration: BoxDecoration(
                            //     borderRadius:
                            //         const BorderRadius.all(Radius.circular(5)),
                            //     color: is_focused
                            //         ? const Color.fromRGBO(216, 216, 216, 1)
                            //         : const Color.fromRGBO(234, 242, 255, 1),
                            //   ),
                            //   child: BrnIconButton(
                            //     name: is_focused ? '已关注' : '回粉',
                            //     direction: Direction.left,
                            //     padding: 4,
                            //     iconWidget: Icon(
                            //       Icons.add,
                            //       color: is_focused
                            //           ? const Color.fromRGBO(153, 153, 153, 1)
                            //           : const Color.fromRGBO(33, 126, 229, 1),
                            //     ),
                            //     style: TextStyle(
                            //         color: is_focused
                            //             ? const Color.fromRGBO(153, 153, 153, 1)
                            //             : const Color.fromRGBO(
                            //                 33, 126, 229, 1)),
                            //     onTap: _onTap_focus,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Center(
                child: Text(
              '以下是历史关注',
              style: TextStyle(
                  color: Color.fromRGBO(125, 125, 125, 1), fontSize: 10),
            )),
          ),
          ...widget.oldMessage
              .map(
                (item) => Container(
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => User(
                                      user_id:
                                          item['payload']['user_id'].toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Container(
                                    width: 39,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(16.0)),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: item['payload']['avatar'],
                                      errorWidget: (context, url, error) {
                                        return Text('出错了');
                                      },
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              LinearProgressIndicator(
                                        value: downloadProgress.progress,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        item['payload']['nick_name'],
                                        style: TextStyle(fontSize: 13),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        '开始关注了你  ${item['payload']['at_time']}',
                                        style: TextStyle(
                                            fontSize: 8,
                                            color: Color.fromRGBO(
                                                125, 125, 125, 1)),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
