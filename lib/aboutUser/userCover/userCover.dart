import 'package:bruno/bruno.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/aboutUser/editMessage/editMessage.dart';
import 'package:flutter_application_1/aboutUser/setting/setting.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../request/apis.dart';

class UserCover extends StatefulWidget {
  final String coverImage;
  final String userName;
  final String decoration;
  final String label;
  final String userImage;
  final int focus_num;
  final int fans_num;
  final int bethumbed_up;
  final String user_id;
  final bool is_focused;

  const UserCover({
    Key? key,
    required this.coverImage,
    required this.userName,
    required this.label,
    required this.focus_num,
    required this.fans_num,
    required this.bethumbed_up,
    required this.user_id,
    required this.is_focused,
    this.userImage = '',
    this.decoration = "暂无描述",
  }) : super(key: key);

  @override
  State<UserCover> createState() => _UserCover();
}

class _UserCover extends State<UserCover> {
  bool is_focus = false;

  @override
  void initState() {
    setState(() {
      print(widget.is_focused);
      is_focus = widget.is_focused;
    });
    super.initState();
  }

  _onTap_focus() async {
    var res = await APIS.focusPeople(
      user_id: int.parse(widget.user_id),
      need_focus: !is_focus,
    );
    if (res.status == 10001) {
      Fluttertoast.showToast(msg: is_focus ? '取消关注成功' : '关注成功');
      setState(() {
        is_focus = !is_focus;
      });
    } else {
      Fluttertoast.showToast(msg: is_focus ? '取消关注失败' : '关注失败');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      // width: double.infinity,
      padding: const EdgeInsets.only(top: 20, left: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        // image: CachedNetworkImage(
        //   imageUrl: widget.coverImage,
        // ),
        image: DecorationImage(
          image: const AssetImage('assets/image/cover.jpg'),
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4), BlendMode.srcOver),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 25,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipOval(
                  child: CachedNetworkImage(
                    width: 90,
                    height: 90,
                    imageUrl: widget.userImage,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            LinearProgressIndicator(
                      value: downloadProgress.progress,
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  margin: const EdgeInsets.only(left: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Text(
                          widget.userName,
                          style: const TextStyle(
                              fontSize: 26, color: Colors.white),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Text(
                          widget.decoration,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Column(
                children: [
                  Text(
                    '${widget.focus_num}',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const Text(
                    '关注',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 30),
                child: Column(
                  children: [
                    Text(
                      '${widget.fans_num}',
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const Text(
                      '粉丝',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 30),
                child: Column(
                  children: [
                    Text(
                      '${widget.bethumbed_up}',
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const Text(
                      '获赞与收藏',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 150,
            child: Wrap(
              children: const [
                Text(
                  '自我介绍xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
                  style: TextStyle(color: Colors.white, height: 1.5),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  BrnTagCustom(
                    tagText: '19岁',
                    backgroundColor: const Color.fromRGBO(153, 153, 153, 0.85),
                    tagBorderRadius: const BorderRadius.all(Radius.circular(5)),
                    textPadding: const EdgeInsets.only(left: 5, right: 5),
                  ),
                  const SizedBox(width: 10),
                  BrnTagCustom(
                    tagText: '重庆',
                    backgroundColor: const Color.fromRGBO(153, 153, 153, 0.85),
                    tagBorderRadius: const BorderRadius.all(Radius.circular(5)),
                    textPadding: const EdgeInsets.only(left: 5, right: 5),
                  ),
                  const SizedBox(width: 10),
                  BrnTagCustom(
                    tagText: '重庆邮电大学',
                    backgroundColor: const Color.fromRGBO(153, 153, 153, 0.85),
                    tagBorderRadius: const BorderRadius.all(Radius.circular(5)),
                    textPadding: const EdgeInsets.only(left: 5, right: 5),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: Row(
                  children: [
                    widget.user_id == 'self'
                        ? SizedBox(
                            height: 30,
                            child: OutlinedButton(
                              onPressed: (() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditMessage(
                                      avatar: widget.userImage,
                                    ),
                                  ),
                                );
                              }),
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                side: const BorderSide(
                                    width: 1.0, color: Colors.white),
                              ),
                              child: const Text(
                                '编辑资料',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        : SizedBox(
                            height: 30,
                            child: OutlinedButton(
                              onPressed: _onTap_focus,
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                side: const BorderSide(
                                    width: 1.0, color: Colors.white),
                              ),
                              child: Text(
                                is_focus ? '已关注' : '关注',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                    const SizedBox(
                      width: 10,
                    ),
                    widget.user_id == 'self'
                        ? SizedBox(
                            height: 30,
                            child: OutlinedButton(
                              onPressed: (() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Setting(),
                                  ),
                                );
                              }),
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                side:
                                    BorderSide(width: 1.0, color: Colors.white),
                              ),
                              child: const Icon(
                                Icons.settings,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          )
                        : Container()
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
