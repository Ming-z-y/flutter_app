import 'dart:ui';

import "package:flutter/material.dart";

class RankItem extends StatefulWidget {
  late int id; // 文章id
  late String title; // 文章标题
  late String imgUrl; //  文章图片
  late int hot; // 热度
  late int index; // 该item的index

  RankItem(
      {super.key,
      required this.id,
      required this.hot,
      required this.imgUrl,
      required this.title,
      required this.index});

  @override
  State<StatefulWidget> createState() {
    return _RankItem(id, hot, imgUrl, title, index);
  }
}

class _RankItem extends State<RankItem> {
  late int id; // 文章id
  late String title; // 文章标题
  late String imgUrl; //  文章图片
  late int hot; // 热度
  late int index; // index
  _RankItem(this.id, this.hot, this.imgUrl, this.title, this.index);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 120,
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1, //宽度
              color: Color.fromRGBO(212, 212, 212, 1), //边框颜色
            ),
          ), // border
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 17,
              height: 17,
              margin: const EdgeInsets.only(top: 5, right: 10),
              decoration: BoxDecoration(
                color: index == 1
                    ? const Color.fromRGBO(255, 74, 58, 1)
                    : index == 2
                        ? const Color.fromRGBO(248, 134, 67, 1)
                        : index == 3
                            ? const Color.fromRGBO(252, 193, 0, 1)
                            : Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(3.0)),
              ),
              child: Text(
                index.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: index > 3
                      ? const Color.fromRGBO(136, 136, 136, 1)
                      : Colors.white,
                ),
              ),
            ),
            Expanded(
                flex: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(
                        '热度 ${hot.toString()}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(136, 136, 136, 1),
                        ),
                      ),
                    )
                  ],
                )),
            Container(
              width: 55,
              height: 55,
              margin: const EdgeInsets.only(left: 10),
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Image.network(
                imgUrl,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
