import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/cache.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../request/apis.dart';
import './generate.dart';
import 'package:flutter_application_1/utils/keepAliveWrapper.dart';
import './userCover/userCover.dart';
import './userCollect/userCollect.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class User extends StatefulWidget {
  final String user_id;
  const User({super.key, required this.user_id});

  @override
  State<User> createState() {
    return _User();
  }
}

class _User extends State<User> {
  var user_data = {};
  bool is_focused = false;

  @override
  void initState() {
    if (widget.user_id == 'self') {
      APIS.getSelfInfo().then((value) {
        if (value.status == 10001) {
          setState(() {
            user_data = value.data!;
          });
        } else {
          Fluttertoast.showToast(msg: '获取信息失败');
        }
      });
    } else {
      APIS.getOtherInfo(user_id: int.parse(widget.user_id)).then((value) {
        if (value.status == 10001) {
          setState(() {
            user_data = value.data!;
            is_focused = value.data!['is_focused'];
            // print(is_focused);
          });
        } else {
          Fluttertoast.showToast(msg: '获取信息失败');
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List tabs = ["作品", "收藏", "点赞"];
    // TODO: implement build
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  expandedHeight: 340,
                  pinned: false,
                  elevation: 0,
                  primary: true,
                  snap: false,
                  surfaceTintColor: Colors.white,
                  flexibleSpace: FlexibleSpaceBar(
                    background: UserCover(
                      coverImage:
                          'https://tse1-mm.cn.bing.net/th/id/OIP-C.jDr1vWoSpnzP7_vgLt-98gAAAA?pid=ImgDet&rs=1',
                      userName: user_data['nick_name'] ?? '',
                      label: '',
                      userImage: user_data['avatar'] ??
                          'https://photo.16pic.com/00/10/41/16pic_1041962_b.jpg',
                      focus_num: user_data['focus_num'] ?? 0,
                      fans_num: user_data['fans_num'] ?? 0,
                      bethumbed_up: user_data['bethumbed_up'] ?? 0,
                      user_id: widget.user_id,
                      is_focused: is_focused,
                    ),
                  ),
                ),
              ),
              const SliverAppBar(
                backgroundColor: Colors.white, // appBar的背景颜色
                pinned: true,
                elevation: 0,
                toolbarHeight: 0,
              ),
              SliverAppBar(
                backgroundColor: Colors.white, // appBar的背景颜色
                pinned: true,
                elevation: 0,
                toolbarHeight: 10,
                expandedHeight: 10,
                flexibleSpace: FlexibleSpaceBar(
                  background: TabBar(
                    unselectedLabelColor: const Color.fromRGBO(94, 83, 109, 1),
                    unselectedLabelStyle:
                        const TextStyle(fontWeight: FontWeight.w400),
                    labelColor: const Color.fromRGBO(41, 31, 54, 1),
                    labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                    tabs: tabs.map((e) => Text(e)).toList(),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: tabs
                .map((e) => KeepAliveWrapper(
                        child: GenerateContent(
                      user_id: widget.user_id,
                      avatar: user_data['avatar'] ??
                          'https://photo.16pic.com/00/10/41/16pic_1041962_b.jpg',
                      tab: e,
                    )))
                .toList(),
          ),
        ),
      ),
    );
  }
}
