import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/articleItem.dart';
import 'package:flutter_application_1/request/apis.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class GenerateContent extends StatefulWidget {
  final String user_id;
  final String avatar;
  const GenerateContent({
    super.key,
    required this.tab,
    required this.avatar,
    required this.user_id,
  });
  final String tab;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GenerateContent();
  }
}

class _GenerateContent extends State<GenerateContent> {
  List data = [];
  bool isEmpty = false;
  String emptyContent = "";

  @override
  void initState() {
    fillEmptyContent();

    _getData();
    super.initState();
  }

  _getData() {
    if (widget.user_id == 'self') {
      if (widget.tab == '作品') {
        APIS.getSelfWork().then((value) {
          if (value.status == 10001) {
            setState(() {
              data = value.data ?? [];
              if (data.isEmpty) isEmpty = true;
            });
          }
        });
      } else if (widget.tab == "收藏") {
        APIS.getSelfCollection().then((value) {
          if (value.status == 10001) {
            setState(() {
              data = value.data ?? [];
              if (data.isEmpty) isEmpty = true;
            });
          }
        });
      } else if (widget.tab == "点赞") {
        APIS.getSelfLike().then((value) {
          if (value.status == 10001) {
            setState(() {
              data = value.data ?? [];
              if (data.isEmpty) isEmpty = true;
            });
          }
        });
      }
    } else {
      if (widget.tab == '作品') {
        APIS.getOtherWork(user_id: int.parse(widget.user_id)).then((value) {
          if (value.status == 10001) {
            setState(() {
              data = value.data ?? [];
              if (data.isEmpty) isEmpty = true;
            });
          }
        });
      } else if (widget.tab == "收藏") {
        APIS
            .getOtherCollection(user_id: int.parse(widget.user_id))
            .then((value) {
          if (value.status == 10001) {
            setState(() {
              data = value.data ?? [];
              if (data.isEmpty) isEmpty = true;
            });
          }
        });
      } else if (widget.tab == "点赞") {
        APIS.getOtherLike(user_id: int.parse(widget.user_id)).then((value) {
          if (value.status == 10001) {
            setState(() {
              data = value.data ?? [];
              if (data.isEmpty) isEmpty = true;
            });
          }
        });
      }
    }
  }

  fillEmptyContent() {
    if (widget.tab == '作品') {
      setState(() {
        emptyContent = "还没有创建作品哦~";
      });
    } else if (widget.tab == '收藏') {
      setState(() {
        emptyContent = "还没有收藏作品哦~";
      });
    } else if (widget.tab == '点赞') {
      setState(() {
        emptyContent = "还没有点赞过作品哦~";
      });
    }
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 2000), () {
      _getData();
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
                        article_id: item["work_id"],
                        img_url: item["img_url"],
                        title: item["title"],
                        create_time: item['create_time'],
                        like_num: item['loved_num'],
                        comment_num: item['comment_num'],
                        watched_num: item['watched_num'],
                        description: item['description'] ?? '',
                        avatar: item['avatar'] ?? widget.avatar,
                        nick_name: item['nick_name'] ?? '',
                        contentUrl: item['content_url'],
                        work_status: item?['status'] ?? '',
                      ),
                    )
                    .toList(),
              )
            : isEmpty
                ? ListView(
                    children: [Center(child: Text(emptyContent))],
                  )
                : const SpinKitPouringHourGlass(
                    color: Color.fromRGBO(138, 135, 240, 1),
                  ));
  }
}
