import 'package:flutter/material.dart';
import '../../components/rankItem.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class Hot extends StatefulWidget {
  const Hot({super.key});

  @override
  State<Hot> createState() {
    // TODO: implement createState
    return _Hot();
  }
}

class _Hot extends State<Hot> {
  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      child: ListView(
        children: [
          RankItem(
            id: 1,
            hot: 100,
            imgUrl:
                'https://ts1.cn.mm.bing.net/th/id/R-C.23034dbcaded6ab4169b9514f76f51b5?rik=mSGADwV9o%2fteUA&riu=http%3a%2f%2fpic.bizhi360.com%2fbbpic%2f40%2f9640_1.jpg&ehk=RYei4n5qyNCPVysJmE2a3WhxSOXqGQMGJcvWBmFyfdg%3d&risl=&pid=ImgRaw&r=0',
            title: '2023最火发型，托尼老师手把手教学，教你如何搭配适合自己的发型',
            index: 1,
          ),
          RankItem(
            id: 1,
            hot: 100,
            imgUrl:
                'https://ts1.cn.mm.bing.net/th/id/R-C.23034dbcaded6ab4169b9514f76f51b5?rik=mSGADwV9o%2fteUA&riu=http%3a%2f%2fpic.bizhi360.com%2fbbpic%2f40%2f9640_1.jpg&ehk=RYei4n5qyNCPVysJmE2a3WhxSOXqGQMGJcvWBmFyfdg%3d&risl=&pid=ImgRaw&r=0',
            title: '2023最火发型，托尼老师手把手教学，教你如何搭配适合自己的发型',
            index: 2,
          ),
          RankItem(
            id: 1,
            hot: 100,
            imgUrl:
                'https://ts1.cn.mm.bing.net/th/id/R-C.23034dbcaded6ab4169b9514f76f51b5?rik=mSGADwV9o%2fteUA&riu=http%3a%2f%2fpic.bizhi360.com%2fbbpic%2f40%2f9640_1.jpg&ehk=RYei4n5qyNCPVysJmE2a3WhxSOXqGQMGJcvWBmFyfdg%3d&risl=&pid=ImgRaw&r=0',
            title: '2023最火发型，托尼老师手把手教学，教你如何搭配适合自己的发型',
            index: 3,
          ),
          RankItem(
            id: 1,
            hot: 100,
            imgUrl:
                'https://ts1.cn.mm.bing.net/th/id/R-C.23034dbcaded6ab4169b9514f76f51b5?rik=mSGADwV9o%2fteUA&riu=http%3a%2f%2fpic.bizhi360.com%2fbbpic%2f40%2f9640_1.jpg&ehk=RYei4n5qyNCPVysJmE2a3WhxSOXqGQMGJcvWBmFyfdg%3d&risl=&pid=ImgRaw&r=0',
            title: '2023最火发型，托尼老师手把手教学，教你如何搭配适合自己的发型',
            index: 4,
          ),
          RankItem(
            id: 1,
            hot: 100,
            imgUrl:
                'https://ts1.cn.mm.bing.net/th/id/R-C.23034dbcaded6ab4169b9514f76f51b5?rik=mSGADwV9o%2fteUA&riu=http%3a%2f%2fpic.bizhi360.com%2fbbpic%2f40%2f9640_1.jpg&ehk=RYei4n5qyNCPVysJmE2a3WhxSOXqGQMGJcvWBmFyfdg%3d&risl=&pid=ImgRaw&r=0',
            title: '2023最火发型，托尼老师手把手教学，教你如何搭配适合自己的发型',
            index: 5,
          ),
          RankItem(
            id: 1,
            hot: 100,
            imgUrl:
                'https://ts1.cn.mm.bing.net/th/id/R-C.23034dbcaded6ab4169b9514f76f51b5?rik=mSGADwV9o%2fteUA&riu=http%3a%2f%2fpic.bizhi360.com%2fbbpic%2f40%2f9640_1.jpg&ehk=RYei4n5qyNCPVysJmE2a3WhxSOXqGQMGJcvWBmFyfdg%3d&risl=&pid=ImgRaw&r=0',
            title: '2023最火发型，托尼老师手把手教学，教你如何搭配适合自己的发型',
            index: 6,
          )
        ],
      ),
    );
  }
}
