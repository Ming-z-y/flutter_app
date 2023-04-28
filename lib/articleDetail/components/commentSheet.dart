import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../request/apis.dart';
import 'commentGroup.dart';

class CommentSheet extends StatefulWidget {
  final int work_id;
  final int user_id;
  const CommentSheet({
    super.key,
    required this.work_id,
    required this.user_id,
  });

  @override
  State<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentSheet> {
  TextEditingController commentController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  var comment = [];
  var rank_type = 2;
  bool is_pointer_user = false;
  int to_user_id = 0;
  int to_comment_id = 0;
  String suffixText = '';

  @override
  void initState() {
    _getComment(rank_type);
    RawKeyboard.instance.addListener(_handleKeyEvent);
    super.initState();
  }

  // 监听键盘删除事件
  void _handleKeyEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent && event.logicalKey.keyLabel == 'Backspace') {
      if (suffixText != '' && commentController.text == '') {
        setState(() {
          suffixText = '';
          is_pointer_user = false;
          to_user_id = 0;
          to_comment_id = 0;
        });
      }
    }
  }

  _getComment(int rank_type) {
    APIS
        .getComment(work_id: widget.work_id, rank_type: rank_type)
        .then((value) {
      if (value.status == 10001) {
        setState(() {
          comment = value.data!;
        });
      }
    });
  }

  publish_comment({
    required int work_id,
    required int worker_id,
    required String content,
    int to_user_id = 0,
    int to_comment_id = 0,
  }) {
    bool isOk = true;
    APIS
        .publishComment(
      content: content,
      work_id: work_id,
      worker_id: worker_id,
      to_user_id: to_user_id,
      to_comment_id: to_comment_id,
    )
        .then((value) {
      if (value.status == 10001) {
        Fluttertoast.showToast(msg: '评论成功~');
        _getComment(rank_type);
        setState(() {
          suffixText = '';
          is_pointer_user = false;
          to_user_id = 0;
          to_comment_id = 0;
        });
        commentController.clear();
      } else {
        Fluttertoast.showToast(msg: '评论失败');
        isOk = false;
      }
    });
    return isOk;
  }

  _pointToUser(String user_name, int to_userid, int to_commentid) {
    setState(() {
      suffixText = '回复 ${user_name}: ';
      is_pointer_user = true;
      to_user_id = to_userid;
      to_comment_id = to_commentid;
      _focusNode.unfocus();
      _focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: Stack(
        children: <Widget>[
          Container(
            height: 30.0,
            width: double.infinity,
            color: Colors.black54,
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
          ),
          Container(
            height: 30,
            margin: const EdgeInsets.only(top: 15),
            child: const Center(
              child: Text(
                '全部评论',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          Container(
            child: Icon(Icons.cancel_outlined),
            margin: EdgeInsets.only(top: 15, left: 360),
          ),
          Container(
            padding: const EdgeInsets.only(
                top: 50.0, bottom: 33.0, left: 20, right: 20),
            decoration: const BoxDecoration(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '评论数 ${comment.length}',
                  style: TextStyle(fontSize: 16),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        if (rank_type != 2) {
                          _getComment(2);
                          setState(() {
                            rank_type = 2;
                          });
                        }
                      },
                      child: Text(
                        '默认',
                        style: TextStyle(
                          color:
                              rank_type == 2 ? Color(0xff00BBBB) : Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        if (rank_type != 1) {
                          _getComment(1);
                          setState(() {
                            rank_type = 1;
                          });
                        }
                      },
                      child: Text(
                        '最新',
                        style: TextStyle(
                          color:
                              rank_type == 1 ? Color(0xff00BBBB) : Colors.black,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 80, bottom: 60),
            child: ListView(
              children: comment.isNotEmpty
                  ? comment.map((item) {
                      return Container(
                        child: CommentGroup(
                          comment_id: item['comment_id'],
                          from_user_id: item['from_user_id'],
                          nick_name: item['nick_name'],
                          avatar: item['avatar'],
                          content: item['content'],
                          at_time: item['at_time'],
                          ip_territory: item['ip_territory'],
                          liked_num: item['liked_num'],
                          sons: item['sons'] ?? [],
                          pointToUser: _pointToUser,
                          work_id: widget.work_id,
                          user_id: widget.user_id,
                        ),
                      );
                    }).toList()
                  : [Center(child: Text('暂无评论'))],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).viewInsets.bottom,
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
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      decoration: const BoxDecoration(
                          color: Color(0xfff6f8fb),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      alignment: Alignment.center,
                      child: TextField(
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(200)
                        ],
                        controller: commentController,
                        focusNode: _focusNode,
                        decoration: InputDecoration(
                          prefixText: suffixText,
                          isDense: true,
                          contentPadding: EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Color(0xffcccccc)),
                          hintText: "小帅哥，快来评论吧",
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (() {
                      var text = commentController.text.trim();
                      if (text.isNotEmpty) {
                        if (is_pointer_user == true) {
                          publish_comment(
                            content: text,
                            work_id: widget.work_id,
                            worker_id: widget.user_id,
                            to_user_id: to_user_id,
                            to_comment_id: to_comment_id,
                          );
                        } else {
                          publish_comment(
                            content: text,
                            work_id: widget.work_id,
                            worker_id: widget.user_id,
                          );
                        }
                      }
                    }),
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 10),
                      alignment: Alignment.center,
                      child: Text(
                        "发送",
                        style: TextStyle(color: Color(0xff00BBBB)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
