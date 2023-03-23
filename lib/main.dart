import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import './home/home.dart'; // 首页页面
import './aboutUser/user.dart'; // 用户页面
import './attention/attention.dart'; //  关注页面
import './message/message.dart'; // 消息页面
import './login/login.dart'; // 登录页面
import './publishArticle/publishArticle.dart'; // 写文章页面
import './utils/cache.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppCache.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Startup Name Generator',
      home: Rooter(),
      // home: EditorPage(),
      // home: HtmlEditorExampleApp(),
      theme: ThemeData(
        backgroundColor: Colors.white,
      ),
    );
  }
}

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: const [
              UserAccountsDrawerHeader(
                  accountName: Text('@com'), accountEmail: Text('ming'))
            ],
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.black12,
          height: 50,
          child: const TabBar(
            labelStyle: TextStyle(height: 0, fontSize: 10),
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                text: "主页",
              ),
              Tab(
                icon: Icon(Icons.shop),
                text: "商城",
              ),
              Tab(
                icon: Icon(Icons.message),
                text: "消息",
              ),
              Tab(
                icon: Icon(Icons.account_circle_sharp),
                text: "我的",
              )
            ],
          ),
        ),
        body: const TabBarView(children: [
          Home(),
          Text('ccc'),
          Text('data'),
          User(),
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          mini: true,
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
      ),
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
  int _currentIndex = 0;
  List<Widget> list = const [Home(), Attention(), MessagePage(), User()];
  _pickerVideo() async {
    var video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    print('video' + video!.path);
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
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "关注"),
            BottomNavigationBarItem(icon: Icon(Icons.message), label: "消息"),
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PublishArticle()));
                }),
              )
            ],
          )),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
