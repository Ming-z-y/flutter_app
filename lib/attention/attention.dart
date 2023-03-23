import 'package:flutter/material.dart';
import '../components/articleItem.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../utils/refreshComponent.dart';

class Attention extends StatefulWidget {
  const Attention({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Attention();
  }
}

class _Attention extends State<Attention> {
  @override
  void initState() {
    EasyLoading.show(status: 'loading...');
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterEasyLoading(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 40,
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Color.fromRGBO(65, 53, 85, 1),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.black38,
              ),
            )
          ],
          title: const Text(
            '关注',
            style: TextStyle(
              color: Color.fromRGBO(65, 53, 85, 1),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: EasyRefresh(
          onRefresh: () async {},
          onLoad: () async {},
          header: CustomRefreshHeader(),
          footer: CustomRefreshFooter(),
          child: ListView(
            children: [
              ArticleItem(
                article_id: 1,
                img_url:
                    'https://tse2-mm.cn.bing.net/th/id/OIP-C.Fx6P4aoVRKGGircQ7tgtggHaEo?pid=ImgDet&rs=1',
                title: '2023最火男士穿搭',
                create_time: '2023-1-12',
                like_num: 117,
                comment_num: 117,
                watched_num: 117,
                description: '本文章预测...',
                avatar: 'https://p.qqan.com/up/2021-6/16234652487190214.png',
                nick_name: '黑皮兔子',
              ),
              ArticleItem(
                article_id: 1,
                img_url:
                    'https://tse2-mm.cn.bing.net/th/id/OIP-C.Fx6P4aoVRKGGircQ7tgtggHaEo?pid=ImgDet&rs=1',
                title: '2023年最火男士',
                create_time: '2023-1-12',
                like_num: 117,
                comment_num: 117,
                watched_num: 117,
                description: '本文章预测...',
                avatar: 'https://p.qqan.com/up/2021-6/16234652487190214.png',
                nick_name: '黑皮兔子',
              ),
              ArticleItem(
                article_id: 1,
                img_url:
                    'https://tse2-mm.cn.bing.net/th/id/OIP-C.Fx6P4aoVRKGGircQ7tgtggHaEo?pid=ImgDet&rs=1',
                title: '2023最火男士穿搭',
                create_time: '2023-1-12',
                like_num: 117,
                comment_num: 117,
                watched_num: 117,
                description: '本文章预测...',
                avatar: 'https://p.qqan.com/up/2021-6/16234652487190214.png',
                nick_name: '黑皮兔子',
              ),
            ],
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
    );
  }
}
