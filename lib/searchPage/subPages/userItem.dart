import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/bumpButton.dart';

import '../../aboutUser/user.dart';

class UserItem extends StatefulWidget {
  final String avatar;
  final String nick_name;
  final int work_num;
  final int fans_num;
  final int user_id;

  const UserItem({
    super.key,
    required this.avatar,
    required this.nick_name,
    required this.work_num,
    required this.fans_num,
    required this.user_id,
  });

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => User(
                        user_id: widget.user_id.toString(),
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 39,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: widget.avatar,
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
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    widget.nick_name,
                    style: TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '笔记 ${widget.work_num}篇    粉丝 ${widget.fans_num}人',
                    style: TextStyle(
                        fontSize: 8, color: Color.fromRGBO(125, 125, 125, 1)),
                  ),
                  SizedBox(height: 5)
                ],
              )
            ],
          ),
          BumpButton(
            user_id: widget.user_id,
            boxHeight: 19,
            fontSize: 10,
            isBumped: false,
            iconSize: 15,
          )
        ],
      ),
    );
  }
}
