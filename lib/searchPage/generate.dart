import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/request/apis.dart';
import 'package:flutter_application_1/searchPage/subPages/userItem.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../components/articleItem.dart';

class Generate extends StatefulWidget {
  final String searchKey;

  /// scope 为1时搜索works，为2时搜索用户
  final int scope;
  const Generate({
    super.key,
    required this.scope,
    required this.searchKey,
  });

  @override
  State<Generate> createState() => _GenerateState();
}

class _GenerateState extends State<Generate> {
  List data = [];
  bool isEmpty = false;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  void didUpdateWidget(Generate old) {
    _getData();
    super.didUpdateWidget(old);
  }

  _getData() {
    if (widget.searchKey != '') {
      APIS.search(scope: widget.scope, key: widget.searchKey).then((value) {
        if (value.status == 10001) {
          setState(() {
            data = value.data ?? [];
          });
          if (data.isEmpty) {
            setState(() {
              isEmpty = true;
            });
          }
        } else {}
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: data.isNotEmpty
          ? widget.scope == 2
              ? ListView(
                  children: data.map((item) {
                    return ArticleItem(
                      article_id: item["work_id"],
                      img_url: item["img_url"],
                      title: item["title"],
                      create_time: item['create_time'],
                      like_num: item['like_num'],
                      comment_num: item['comment_num'],
                      watched_num: item['watched_num'],
                      description: item['description'] ?? '',
                      avatar: item['avatar'],
                      nick_name: item['nick_name'],
                      contentUrl: item['content_url'],
                    );
                  }).toList(),
                )
              : ListView(
                  children: data
                      .map((item) => UserItem(
                            avatar: item['avatar'],
                            nick_name: item['nick_name'],
                            work_num: item['work_num'] ?? 0,
                            fans_num: item['fan_num'] ?? 0,
                            user_id: item['user_id'] ?? 0,
                          ))
                      .toList(),
                )
          : isEmpty
              ? ListView(
                  children: const [
                    Center(
                      child: Text('当前页为空'),
                    ),
                  ],
                )
              : const SpinKitPouringHourGlass(
                  color: Color.fromRGBO(138, 135, 240, 1),
                ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //   return Container(
  //     padding: const EdgeInsets.all(20),
  //     child: ListView.builder(
  //       itemBuilder: ((context, index) {
  //         return UserItem(
  //           avatar:
  //               'https://img.wxcha.com/m00/d9/57/2beacfbc1f0eb295cbfc0c5881839fe2.jpg?down',
  //           nick_name: 'Matthew',
  //           work_num: 12,
  //           fans_num: 11,
  //         );
  //       }),
  //       itemCount: 20,
  //     ),
  //   );
  // }
}
