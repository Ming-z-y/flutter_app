import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/articleDetail/components/commentGroup.dart';
import 'package:flutter_application_1/request/apis.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html_editor_enhanced/utils/utils.dart';

Future<void> showComments({
  required BuildContext context,
  required List data,
  required int work_id,
  required int worker_id,
  required Function getComment,
}) {
  TextEditingController editingController = TextEditingController();

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
        editingController.clear();
      } else {
        Fluttertoast.showToast(msg: '评论失败');
        isOk = false;
      }
    });
    return isOk;
  }

  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return StatefulBuilder(builder: ((context, state) {
        return SizedBox(
          height: 600,
          child: Stack(
            children: <Widget>[
              Container(
                height: 30.0,
                width: double.infinity,
                color: Colors.black54,
                child: Text('xx'),
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
                child: Icon(Icons.assistant_navigation),
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
                      '评论数 9',
                      style: TextStyle(fontSize: 16),
                    ),
                    Row(
                      children: [Text('默认'), Text('最新')],
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 80, bottom: 60),
                child: ListView(
                  children: data.isNotEmpty
                      ? data.map((item) {
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          alignment: Alignment.center,
                          child: TextField(
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(200)
                            ],
                            controller: editingController,
                            decoration: const InputDecoration(
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
                          var text = editingController.text.trim();
                          if (text.isNotEmpty) {
                            var res = publish_comment(
                              content: text,
                              work_id: work_id,
                              worker_id: worker_id,
                            );
                            print(res);
                            if (res) {
                              state(() {
                                getComment();
                              });
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
      }));
    },
  );
}
