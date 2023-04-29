import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_refresh/easy_refresh.dart';
import "package:flutter/material.dart";
import 'package:flutter_application_1/articleDetail/articleDetail.dart';
import 'package:flutter_application_1/components/errorImage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ArticleItem extends StatefulWidget {
  late int article_id; // 文章id
  late String img_url; // 文章url
  late String title; // 文章标题
  late String create_time; // 创作时间
  late int like_num; // 喜欢人数
  late int comment_num; // 评论人数
  late int watched_num; // 观看人数
  late String description; // 文章简介
  late String avatar; // 用户头像
  late String nick_name; // 用户名
  late String contentUrl;
  late String work_status;

  ArticleItem({
    super.key,
    required this.article_id,
    required this.img_url,
    required this.title,
    required this.create_time,
    required this.like_num,
    required this.comment_num,
    required this.watched_num,
    required this.description,
    required this.avatar,
    required this.nick_name,
    required this.contentUrl,
    this.work_status = '',
  });

  @override
  State<StatefulWidget> createState() {
    return _ArticleItem();
  }
}

class _ArticleItem extends State<ArticleItem> {
  _ArticleItem();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              if (widget.work_status == '审核中') {
                Fluttertoast.showToast(msg: '作品待审核哦');
                return;
              }
              if (widget.work_status == '未通过') {
                Fluttertoast.showToast(msg: '作品没有通过审核哦');
                return;
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticleDetail(
                    work_id: widget.article_id,
                  ),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // height: 190,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  ),
                  child: AspectRatio(
                    aspectRatio: 329 / 190,
                    child: CachedNetworkImage(
                      imageUrl: widget.img_url,
                      fit: BoxFit.fill,
                      progressIndicatorBuilder: (context, url, progress) {
                        return Center(
                          child: Container(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              value: progress.progress,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, top: 5),
                  child: Wrap(
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, top: 5),
                  child: Text(widget.work_status),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, top: 5),
                  child: Text(
                    widget.description.isEmpty ? '暂无描述' : widget.description,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      width: 35,
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: widget.avatar,
                        errorWidget: errorWidget,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                LinearProgressIndicator(
                          value: downloadProgress.progress,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        widget.nick_name,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    Container(
                      width: 100,
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      child: Text(
                        '${widget.create_time}   ${widget.watched_num}观看',
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 35, top: 5),
                      child: Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            color: Color.fromRGBO(255, 109, 109, 1),
                            size: 12,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${widget.like_num}',
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10, top: 5),
                      child: Row(
                        children: [
                          Icon(
                            Icons.chat,
                            size: 12,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${widget.comment_num}',
                            style: TextStyle(fontSize: 10),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Expanded(
                    child: SizedBox(
                  width: 5,
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
