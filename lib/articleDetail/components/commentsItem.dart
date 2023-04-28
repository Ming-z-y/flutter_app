import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/request/apis.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommentsItem extends StatefulWidget {
  final int comment_id;
  final int from_user_id;
  final String nick_name;
  final String avatar;
  final String content;
  final String at_time;
  final String ip_territory;
  final int liked_num;
  final bool isTop;
  final int work_id;
  final int user_id;
  final Function(String user_name, int to_user, int to_comment) pointToUser;
  const CommentsItem({
    super.key,
    required this.comment_id,
    required this.from_user_id,
    required this.nick_name,
    required this.avatar,
    required this.content,
    required this.at_time,
    required this.ip_territory,
    required this.liked_num,
    required this.pointToUser,
    required this.isTop,
    required this.work_id,
    required this.user_id,
  });

  @override
  State<CommentsItem> createState() => _CommentsItemState();
}

class _CommentsItemState extends State<CommentsItem> {
  // 后面使用接口中获得的 need_like
  bool need_like = true;
  int like_num = 0;

  @override
  void initState() {
    setState(() {
      like_num = widget.liked_num;
    });
    super.initState();
  }

  _bumped_comment() async {
    var res = await APIS.like_comment(
      comment_id: widget.comment_id,
      work_id: widget.work_id,
      need_like: need_like,
      is_top: widget.isTop,
      worker_id: widget.user_id,
    );
    if (res.status == 10001) {
      setState(() {
        if (need_like) {
          like_num += 1;
        } else {
          like_num -= 1;
        }
        need_like = !need_like;
      });
    } else {
      Fluttertoast.showToast(msg: '点赞失败');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      margin: const EdgeInsets.only(top: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 35,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
            child: CachedNetworkImage(
              imageUrl: widget.avatar,
              errorWidget: (context, url, error) {
                return Image.asset('assets/image/avatar.jpg');
              },
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  LinearProgressIndicator(
                value: downloadProgress.progress,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.nick_name,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 3),
              Text(
                widget.content,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 3),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${widget.at_time} ${widget.ip_territory}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(153, 153, 153, 1),
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            widget.pointToUser(
                              widget.nick_name,
                              widget.from_user_id,
                              widget.comment_id,
                            );
                          },
                          child: const Icon(
                            Icons.message,
                            size: 13,
                          ),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () {
                            _bumped_comment();
                          },
                          child: Icon(
                            need_like ? Icons.favorite_border : Icons.favorite,
                            color: need_like ? Colors.black : Colors.red,
                            size: 13,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text('${like_num}', style: TextStyle(fontSize: 10))
                      ],
                    ),
                  ],
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
