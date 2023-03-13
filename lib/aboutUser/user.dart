import 'dart:ui';
import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import './userCover/userCover.dart';
import './userCollect/userCollect.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() {
    return _User();
  }
}

class _User extends State<User> {
  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      child: Column(children: const [
        UserCover(
          coverImage:
              'https://tse1-mm.cn.bing.net/th/id/OIP-C.jDr1vWoSpnzP7_vgLt-98gAAAA?pid=ImgDet&rs=1',
          userName: 'MING',
          label: '',
          userImage:
              'https://ts1.cn.mm.bing.net/th?id=OIP-C.ZwHbUNuM0nfxmPkkgMKKZAAAAA&w=250&h=250&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2',
        ),
        UserCollect()
      ]),
    );
    // return CustomScrollView(
    //   slivers: [
    //     SliverGrid.count(
    //       crossAxisCount: 1,
    //       children: List.generate(
    //         1,
    //         (index) {
    //           return const UserCover(
    //             coverImage:
    //                 'https://tse1-mm.cn.bing.net/th/id/OIP-C.jDr1vWoSpnzP7_vgLt-98gAAAA?pid=ImgDet&rs=1',
    //             userName: 'MING',
    //             label: '',
    //             userImage:
    //                 'https://ts1.cn.mm.bing.net/th?id=OIP-C.ZwHbUNuM0nfxmPkkgMKKZAAAAA&w=250&h=250&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2',
    //           );
    //         },
    //       ).toList(),
    //     ),
    //     SliverPersistentHeader(
    //       delegate: _MyDelegate(),
    //       pinned: true,
    //     ),
    //     SliverList(
    //       delegate: SliverChildBuilderDelegate((content, index) {
    //         return Container(
    //           height: 85,
    //           alignment: Alignment.center,
    //           color: Colors.white,
    //           child: ListTile(
    //             title: Text('消息通知: $index'),
    //             leading: Container(
    //               height: 50,
    //               width: 50,
    //               decoration: const BoxDecoration(
    //                   color: Color.fromRGBO(217, 217, 217, 1),
    //                   borderRadius: BorderRadius.all(Radius.circular(25))),
    //             ),
    //             subtitle: const Text('xxxxxxxxxxxxxxxxxxx'),
    //             trailing: Column(children: [
    //               const Text('昨天'),
    //               const SizedBox(
    //                 height: 5,
    //               ),
    //               Container(
    //                 width: 18,
    //                 height: 18,
    //                 decoration: const BoxDecoration(
    //                   color: Color.fromRGBO(255, 90, 90, 1),
    //                   borderRadius: BorderRadius.all(Radius.circular(9.0)),
    //                 ),
    //                 child: Center(
    //                     child: Text(
    //                   index.toString(),
    //                   style: TextStyle(color: Colors.white),
    //                 )),
    //               )
    //             ]),
    //           ),
    //         );
    //       }, childCount: 10),
    //     )
    //   ],
    // );
  }
}

class _MyDelegate extends SliverPersistentHeaderDelegate {
  late TabController tabController;
  late List<BadgeTab> tabs;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // return BrnTabBar(controller: tabController, tabs: [
    //   BadgeTab(text: '作品'),
    //   BadgeTab(text: '收藏'),
    //   BadgeTab(text: '点赞')
    // ]);
    return Text('dsad');
  }

  ///最高高度
  @override
  double get maxExtent => 35;

  ///最新高度
  @override
  double get minExtent => 35;

  ///重绘
  @override
  bool shouldRebuild(covariant _MyDelegate oldDelegate) {
    //如果 title 不相等，则重绘
    // return oldDelegate.title != title;
    return false;
  }
}
