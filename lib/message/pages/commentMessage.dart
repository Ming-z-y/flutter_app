import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../aboutUser/user.dart';

class CommentMessage extends StatefulWidget {
  final List oldMessage;
  final List newMessage;
  final Function(int index, int t) onChange;
  const CommentMessage({
    super.key,
    required this.oldMessage,
    required this.newMessage,
    required this.onChange,
  });

  @override
  State<CommentMessage> createState() => _CommentMessage();
}

class _CommentMessage extends State<CommentMessage> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 5), () async {
      widget.onChange(2, widget.newMessage.length);
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
          '新增评论',
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      user_id: item['payload']['from_user_id']
                                          .toString(),
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
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => ArticleDetail(work_id: work_id)
                                //   ),
                                // );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item['payload']['nick_name'],
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    '评论了你的${item['payload']['scope']}  ${item['payload']['at_time']}',
                                    style: TextStyle(
                                        fontSize: 8,
                                        color:
                                            Color.fromRGBO(125, 125, 125, 1)),
                                  ),
                                  SizedBox(height: 8),
                                  // Text(
                                  //   '${item['payload']['title'] ?? ''}',
                                  //   style: TextStyle(fontSize: 10),
                                  // ),
                                  Text(
                                    '${item['payload']['content'] ?? ''}',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 38,
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(3.0)),
                        ),
                        // child: CachedNetworkImage(
                        //   fit: BoxFit.fill,
                        //   imageUrl: item['payload']['image_url'],
                        //   errorWidget: (context, url, error) {
                        //     return Text('出错了');
                        //   },
                        //   progressIndicatorBuilder:
                        //       (context, url, downloadProgress) =>
                        //           CircularProgressIndicator(
                        //     value: downloadProgress.progress,
                        //   ),
                        // ),
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
              '以下是历史评论',
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      user_id: item['payload']['from_user_id']
                                          .toString(),
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
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => ArticleDetail(work_id: work_id)
                                //   ),
                                // );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item['payload']['nick_name'],
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    '评论了你的${item['payload']['scope']}  ${item['payload']['at_time']}',
                                    style: TextStyle(
                                        fontSize: 8,
                                        color:
                                            Color.fromRGBO(125, 125, 125, 1)),
                                  ),
                                  SizedBox(height: 8),
                                  // Text(
                                  //   '${item['payload']['title'] ?? ''}',
                                  //   style: TextStyle(fontSize: 10),
                                  // ),
                                  Text(
                                    '${item['payload']['content'] ?? ''}',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 38,
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(3.0)),
                        ),
                        // child: CachedNetworkImage(
                        //   fit: BoxFit.fill,
                        //   imageUrl: item['payload']['image_url'],
                        //   errorWidget: (context, url, error) {
                        //     return Text('出错了');
                        //   },
                        //   progressIndicatorBuilder:
                        //       (context, url, downloadProgress) =>
                        //           CircularProgressIndicator(
                        //     value: downloadProgress.progress,
                        //   ),
                        // ),
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
