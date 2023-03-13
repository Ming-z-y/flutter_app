import 'dart:ui';

import "package:flutter/material.dart";

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
  });

  @override
  State<StatefulWidget> createState() {
    return _ArticleItem(
      article_id,
      avatar,
      comment_num,
      create_time,
      description,
      img_url,
      like_num,
      nick_name,
      title,
      watched_num,
    );
  }
}

class _ArticleItem extends State<ArticleItem> {
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
  _ArticleItem(
      this.article_id,
      this.avatar,
      this.comment_num,
      this.create_time,
      this.description,
      this.img_url,
      this.like_num,
      this.nick_name,
      this.title,
      this.watched_num);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
            child: Image.network(img_url),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, top: 5),
            child: Text(
              title,
              style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, top: 5),
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 35,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  ),
                  child: Image.network(avatar),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    nick_name,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 5, right: 5, top: 10),
                  child: Text(create_time),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, left: 5),
                  child: Text('$watched_num观看'),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 35, top: 5),
                  child: Text('$like_num'),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, top: 5),
                  child: Text('$comment_num'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
