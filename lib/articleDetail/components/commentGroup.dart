import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/articleDetail/components/commentsItem.dart';

class CommentGroup extends StatefulWidget {
  final int comment_id;
  final int from_user_id;
  final String nick_name;
  final String avatar;
  final String content;
  final String at_time;
  final String ip_territory;
  final int liked_num;
  final List sons;
  const CommentGroup({
    super.key,
    required this.comment_id,
    required this.from_user_id,
    required this.nick_name,
    required this.avatar,
    required this.content,
    required this.at_time,
    required this.ip_territory,
    required this.liked_num,
    required this.sons,
  });

  @override
  State<CommentGroup> createState() => _CommentGroupState();
}

class _CommentGroupState extends State<CommentGroup> {
  var tabs = ['a', 'b', 'c'];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommentsItem(
          comment_id: widget.comment_id,
          from_user_id: widget.from_user_id,
          nick_name: widget.nick_name,
          avatar: widget.avatar,
          content: widget.content,
          at_time: widget.at_time,
          ip_territory: widget.ip_territory,
          liked_num: widget.liked_num,
        ),
        // widget.sons.isNotEmpty
        //     ? tabs.map((e) => Text('xx')).toList()
        //     : Container()
        ...widget.sons
            .map((item) => Container(
                  padding: EdgeInsets.only(left: 35),
                  margin: EdgeInsets.only(top: 5),
                  child: CommentsItem(
                    comment_id: item['comment_id'],
                    from_user_id: item['from_user_id'],
                    nick_name: item['nick_name'],
                    avatar: item['avatar'],
                    content: item['content'],
                    at_time: item['at_time'],
                    ip_territory: item['ip_territory'],
                    liked_num: item['liked_num'],
                  ),
                ))
            .toList()
      ],
    );
  }
}
