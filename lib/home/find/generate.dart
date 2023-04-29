import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/articleItem.dart';
import 'package:flutter_application_1/request/apis.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class GenerateContent extends StatefulWidget {
  const GenerateContent({super.key, required this.tab});
  final String tab;

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
    widget.tab != '推荐'
        ? APIS
            .workRecommend(page_num, page_size, type: widget.tab)
            .then((value) {
            if (value.status == 10001) {
              setState(() {
                data = value.data!["works"];
              });
              if (data.isEmpty) {
                setState(() {
                  isEmpty = true;
                });
              }
            }
          })
        : APIS.workRecommend(page_num, page_size).then(
            (value) {
              if (value.status == 10001) {
                setState(() {
                  data = value.data!["works"];
                });
                if (data.isEmpty)
                  setState(() {
                    isEmpty = true;
                  });
              }
            },
          );
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 2000), () {
      getData();
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
                      article_id: item["article_id"],
                      img_url: item["img_url"],
                      title: item["title"],
                      create_time: item['create_time'],
                      like_num: item['like_num'],
                      comment_num: item['comment_num'],
                      watched_num: item['watched_num'],
                      description: item['description'],
                      avatar: item['avatar'],
                      nick_name: item['nick_name'],
                      contentUrl: item['content_url'],
                    ),
                  )
                  .toList(),
            )
          : isEmpty
              ? ListView(
                  children: [
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
}
