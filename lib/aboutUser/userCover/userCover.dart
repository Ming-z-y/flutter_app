import 'package:flutter/material.dart';

class UserCover extends StatefulWidget {
  UserCover({
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
  _UserCover createState() {
    // TODO: implement createState
    return _UserCover();
  }
}

class _UserCover extends State<UserCover> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.green,
        image: DecorationImage(
          image: NetworkImage(widget.coverImage),
          fit: BoxFit.fill,
        ),
      ),
      child: ListView(
        children: [
          Container(
            width: 20,
            margin: EdgeInsetsDirectional.only(top: 20, end: 150),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipOval(
                  child: Image(
                    width: 100,
                    height: 100,
                    image: NetworkImage(widget.userImage),
                  ),
                ),
                Container(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        widget.userName,
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      Text(
                        widget.decoration,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
