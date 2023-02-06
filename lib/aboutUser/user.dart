import 'dart:ui';
import 'package:flutter/material.dart';
import './userCover/userCover.dart';
import './userCollect/userCollect.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() {
    // TODO: implement createState
    return _User();
  }
}

class _User extends State<User> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        UserCover(
          coverImage:
              'https://ts1.cn.mm.bing.net/th?id=OIP-C.6Vwj50mUIJuUYohQ7S-M2gHaEK&w=333&h=187&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2',
          userName: 'MING',
          label: '',
          userImage:
              'https://ts1.cn.mm.bing.net/th?id=OIP-C.ZwHbUNuM0nfxmPkkgMKKZAAAAA&w=250&h=250&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2',
        ),
        UserCollect()
      ],
    );
  }
}
