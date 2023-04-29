import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/articleItem.dart';
import 'package:flutter_application_1/request/apis.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class GenerateContent extends StatefulWidget {
  final bool isFull;
  final int user_id;
  final Function() onRefresh;
  const GenerateContent({
    super.key,
    required this.isFull,
    required this.user_id,
    required this.onRefresh,
  });

  @override
  State<StatefulWidget> createState() {
    return _GenerateContent();
  }
}

class _GenerateContent extends State<GenerateContent> {
  List data = [];
  bool isEmpty = false;
  int page_num = 1;
  int page_size = 10;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() {
    widget.isFull
        ? APIS.getFocusWork(cursor: 0).then(
            (value) {
              if (value.status == 10001) {
                setState(() {
                  data = value.data!["get_focus_works"] ?? [];
                });
                if (data.isEmpty) {
                  setState(() {
                    isEmpty = true;
                  });
                }
              }
            },
          )
        : APIS.getFocusWork(user_id: widget.user_id).then(
            (value) {
              if (value.status == 10001) {
                setState(() {
                  data = value.data!["get_focus_works"] ?? [];
                });
                if (data.isEmpty) {
                  setState(() {
                    isEmpty = true;
                  });
                }
              }
            },
          );
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 2000), () {
      getData();
      widget.onRefresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: data.isNotEmpty
          ? ListView(
              children: data
                  .map(
                    (item) => ArticleItem(
                      article_id: item["work_id"] ?? 0,
                      img_url: item["img_url"] ?? '',
                      title: item["title"] ?? '',
                      create_time: item['create_time'] ?? '',
                      like_num: item['loved_num'] ?? 0,
                      comment_num: item['comment_num'] ?? 0,
                      watched_num: item['watched_num'] ?? 0,
                      description: item['description'] ?? '',
                      avatar: item['avatar'] ?? '',
                      nick_name: item['nick_name'] ?? '',
                      contentUrl: item['content_url'] ?? '',
                    ),
                  )
                  .toList(),
            )
          : isEmpty
              ? ListView(
                  children: [Center(child: Text('关注者还没有发动态哦'))],
                )
              : const SpinKitPouringHourGlass(
                  color: Color.fromRGBO(138, 135, 240, 1),
                ),
    );
  }
}
