import 'package:flutter/material.dart';

class UserCollect extends StatefulWidget {
  @override
  _UserCollect createState() {
    // TODO: implement createState
    return _UserCollect();
  }
}

class _UserCollect extends State<UserCollect> {
  final List list = ["作品", "收藏", "点赞"];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: ListView(
        shrinkWrap: true, //解决无限高度问题
        physics: new NeverScrollableScrollPhysics(),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: list
                .map((item) => Text(
                      item,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ))
                .toList(),
          ),
          Text('div')
        ],
      ),
    );
  }
}
