import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/publishArticle/reviewUploadVideo.dart';
import 'package:flutter_application_1/publishArticle/uploadResult.dart';
import 'package:flutter_application_1/utils/chooseIsGetCamera.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import './home/home.dart'; // 首页页面
import './aboutUser/user.dart'; // 用户页面
import './attention/attention.dart'; //  关注页面
import './message/message.dart'; // 消息页面
import './login/login.dart'; // 登录页面
import './publishArticle/publishArticle.dart'; // 写文章页面
import './utils/cache.dart';
import 'utils/eventBus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppCache.init();
  EventBusUtils.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': ((context) => LoginPage()),
        '/home': (context) => Rooter()
      },
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Startup Name Generator',
      home: Rooter(),
      // home: LoginPage(),
      theme: ThemeData(
        backgroundColor: Colors.white,
      ),
      builder: EasyLoading.init(),
    );
  }
}

class Rooter extends StatefulWidget {
  const Rooter({super.key});

  @override
  State<Rooter> createState() {
    return _Rooter();
  }
}

class _Rooter extends State<Rooter> {
  int messageNum = 0;

  @override
  void initState() {
    EventBusUtils.getInstance().on<EventBus_data>().listen((event) {
      if (event.number != 0) {
        setState(() {
          messageNum = event.number;
        });
      }
    });
    super.initState();
  }

  int _currentIndex = 0;
  List<Widget> list = const [
    Home(),
    Attention(),
    MessagePage(),
    User(
      /// 根据self来判断是自己还是其他用户
      user_id: 'self',
    )
  ];

  _pickerVideo() async {
    int? isGetCamera = await chooseIsGetCamera(context: context);
    ChooseMethod.setIsGetCamera(0);
    String path = 'error';
    if (isGetCamera == 0) return;
    if (isGetCamera == 1) {
      path = await chooseVideoPath(isGetCamera: true);
    } else if (isGetCamera == 2) {
      path = await chooseVideoPath(isGetCamera: false);
    }

    if (path != 'error') {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ReviewUploadVideo(url: path)),
      );
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    // 设置开始的导航栏和样式
    return Scaffold(
      // 使用IndexedStack实现页面间的缓存
      body: IndexedStack(
        index: _currentIndex,
        children: list,
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          fixedColor: const Color.fromRGBO(121, 119, 238, 1),
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) => {
                setState(
                  () {
                    _currentIndex = index;
                  },
                )
              },
          selectedFontSize: 14,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "关注"),
            BottomNavigationBarItem(
                icon: messageNum != 0
                    ? Stack(
                        children: [
                          Container(
                            child: Icon(Icons.message),
                          ),
                          Positioned(
                            right: -1,
                            child: Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                            ),
                          )
                        ],
                      )
                    : Icon(Icons.message),
                label: "消息"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_sharp), label: "我的"),
          ]),
      floatingActionButton: Container(
          width: 50,
          height: 50,
          padding: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: SpeedDial(
            backgroundColor: const Color.fromRGBO(121, 119, 238, 1),
            direction: SpeedDialDirection.up,
            icon: Icons.add,
            childMargin: const EdgeInsets.only(left: 20),
            spaceBetweenChildren: 5,
            children: [
              SpeedDialChild(
                label: "发视频",
                labelBackgroundColor: const Color.fromRGBO(121, 119, 238, 1),
                labelStyle: const TextStyle(color: Colors.white),
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
                onTap: (() {
                  _pickerVideo();
                }),
              ),
              SpeedDialChild(
                label: "发想法",
                labelBackgroundColor: const Color.fromRGBO(121, 119, 238, 1),
                labelStyle: const TextStyle(color: Colors.white),
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
                onTap: (() {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PublishArticle(),
                    ),
                  );
                }),
              )
            ],
          )),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
