import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/aboutUser/editMessage/editMessage.dart';

class UserCover extends StatefulWidget {
  const UserCover({
    Key? key,
    required this.coverImage,
    required this.userName,
    required this.label,
    this.userImage = '',
    this.decoration = "暂无描述",
  }) : super(key: key);

  final String coverImage;
  final String userName;
  final String decoration;
  final String label;
  final String userImage;

  @override
  State<UserCover> createState() {
    return _UserCover();
  }
}

class _UserCover extends State<UserCover> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      // width: double.infinity,
      padding: const EdgeInsets.only(top: 20, left: 20),
      decoration: BoxDecoration(
        color: Colors.green,
        image: DecorationImage(
          image: NetworkImage(widget.coverImage),
          fit: BoxFit.fill,
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
                  child: Image(
                    width: 90,
                    height: 90,
                    image: NetworkImage(widget.userImage),
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
                children: const [
                  Text(
                    '651',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    '关注',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 30),
                child: Column(
                  children: const [
                    Text(
                      '651',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Text(
                      '粉丝',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 30),
                child: Column(
                  children: const [
                    Text(
                      '123991',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Text(
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
                    tagText: '30岁',
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
                    SizedBox(
                      height: 30,
                      child: OutlinedButton(
                        onPressed: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditMessage()));
                        }),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          side:
                              const BorderSide(width: 1.0, color: Colors.white),
                        ),
                        child: const Text(
                          '编辑资料',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      height: 30,
                      child: OutlinedButton(
                        onPressed: (() {}),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          side: BorderSide(width: 1.0, color: Colors.white),
                        ),
                        child: const Text(
                          '修改',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
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
