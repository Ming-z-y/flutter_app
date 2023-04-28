import 'dart:io';
import 'package:bruno/bruno.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/aboutUser/user.dart';
import 'package:flutter_application_1/articleDetail/comments.dart';
import 'package:flutter_application_1/articleDetail/components/videoWeapper.dart';
import 'package:flutter_application_1/publishArticle/publishVideoWeapper.dart';
import 'package:flutter_application_1/request/apis.dart';
import 'package:flutter_application_1/request/httpUtil.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

class ArticleDetail extends StatefulWidget {
  final int work_id;
  const ArticleDetail({
    super.key,
    required this.work_id,
  });

  @override
  State<ArticleDetail> createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetail> {
  bool is_focused = false;
  bool is_liked = false;
  bool is_collected = false;
  int scope = 0;
  String content = "";
  List comment = [];
  Map<String, dynamic> data = {};

  _content(String url, int scope) {
    if (scope == 1) {
      Dio dio = Dio();
      if (content == '') {
        dio.get(url).then((value) {
          if (mounted) {
            setState(() {
              content = value.data;
            });
          }
        });
      }
      return Html(data: content);
    } else if (scope == 2) {
      return VideoWeapper(url: url);
    } else {
      return Text('加载中');
    }
  }

  @override
  void initState() {
    // 初始化
    APIS.getDetail(work_id: widget.work_id).then((value) {
      if (value.status == 10001) {
        setState(() {
          data = value.data!;
          is_focused = value.data!['is_focused'];
          is_collected = value.data!['is_collected'];
          is_liked = value.data!['is_liked'];
        });
      }
    });
    _getComment();
    super.initState();
  }

  _getComment() {
    APIS.getComment(work_id: widget.work_id, rank_type: 1).then((value) {
      print(value.info);
      print(value.data);
      print(value.status);
      if (value.status == 10001) {
        setState(() {
          comment = value.data!;
        });
      }
    });
  }

  _onTap_focus() async {
    var res = await APIS.focusPeople(
      user_id: data['user_id'],
      need_focus: !is_focused,
    );
    if (res.status == 10001) {
      Fluttertoast.showToast(msg: is_focused ? '取消关注成功' : '关注成功');
      setState(() {
        is_focused = !is_focused;
      });
    } else {
      Fluttertoast.showToast(msg: is_focused ? '取消关注失败' : '关注失败');
    }
  }

  _onTap_like() async {
    var res = await APIS.like_work(
      work_id: data['article_id'],
      need_like: !is_liked,
      worker_id: data['user_id'],
    );
    if (res.status == 10001) {
      setState(() {
        is_liked = !is_liked;
      });
    } else {
      Fluttertoast.showToast(msg: '操作失败');
    }
  }

  _onTap_collect() async {
    var res = await APIS.collection(
      work_id: data['article_id'],
      need_collect: !is_collected,
    );
    print(res.status);
    print(res.info);
    if (res.status == 10001) {
      setState(() {
        is_collected = !is_collected;
      });
    } else {
      Fluttertoast.showToast(msg: '操作失败');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 40,
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Color.fromRGBO(65, 53, 85, 1),
          ),
          title: const Text(
            '文章详细',
            style: TextStyle(
              color: Color.fromRGBO(65, 53, 85, 1),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: data.isNotEmpty
            ? Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: ListView(
                      children: [
                        // title
                        Text(
                          data['title'],
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w400),
                        ),
                        // 头像
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
                                        user_id: data['user_id'].toString(),
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      width: 35,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16.0)),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: data['avatar'],
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
                                          data['nick_name'],
                                          style: TextStyle(fontSize: 13),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          '${data['create_time']}    ${data['watched_num']}阅读',
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
                              Container(
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                  color: is_focused
                                      ? const Color.fromRGBO(216, 216, 216, 1)
                                      : const Color.fromRGBO(234, 242, 255, 1),
                                ),
                                child: BrnIconButton(
                                  name: is_focused ? '已关注' : '关注',
                                  direction: Direction.left,
                                  padding: 4,
                                  iconWidget: Icon(
                                    Icons.add,
                                    color: is_focused
                                        ? const Color.fromRGBO(153, 153, 153, 1)
                                        : const Color.fromRGBO(33, 126, 229, 1),
                                  ),
                                  style: TextStyle(
                                      color: is_focused
                                          ? const Color.fromRGBO(
                                              153, 153, 153, 1)
                                          : const Color.fromRGBO(
                                              33, 126, 229, 1)),
                                  onTap: _onTap_focus,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Text(data['content_url']),
                        // 内容
                        data.isNotEmpty
                            ? _content(data['content_url'], data['scope'] ?? 0)
                            : const Text('加载中')
                      ],
                    ),
                  ),
                  // 底部评论
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 55,
                      padding: const EdgeInsets.only(left: 20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x2B000000),
                              offset: Offset(0.0, -8.0), //阴影xy轴偏移量
                              blurRadius: 15.0, //阴影模糊程度
                              spreadRadius: -11 //阴影扩散程度
                              )
                        ],
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              showComments(
                                context: context,
                                data: comment,
                                work_id: data['article_id'],
                                worker_id: data['user_id'],
                                getComment: _getComment,
                              );
                            },
                            child: Container(
                              height: 33,
                              width: 250,
                              padding: const EdgeInsets.only(left: 10, top: 5),
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(237, 237, 237, 1),
                                  borderRadius: BorderRadius.circular(9)),
                              child: const Text(
                                '小帅哥，快来评论吧~',
                                style: TextStyle(
                                    color: Color.fromRGBO(105, 105, 105, 1)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              print('object');
                            },
                            child: const Icon(
                              Icons.markunread_outlined,
                              size: 16,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: _onTap_like,
                            child: Icon(
                              is_liked ? Icons.favorite : Icons.favorite_border,
                              color: is_liked
                                  ? const Color.fromRGBO(255, 109, 109, 1)
                                  : Colors.black54,
                              size: 16,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: _onTap_collect,
                            child: Icon(
                              is_collected ? Icons.star : Icons.star_border,
                              color:
                                  is_collected ? Colors.amber : Colors.black54,
                              size: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Text('加载中'));
  }
}
