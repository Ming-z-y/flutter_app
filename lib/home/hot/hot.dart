import 'package:flutter/material.dart';
import 'package:flutter_application_1/request/apis.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../components/rankItem.dart';

class Hot extends StatefulWidget {
  const Hot({super.key});

  @override
  State<Hot> createState() {
    return _Hot();
  }
}

class _Hot extends State<Hot> {
  List content = [];
  var index = 1;
  bool isEmpty = false;
  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() {
    APIS.hot().then((value) {
      print(value.info);
      print(value.status);
      setState(() {
        content = value.data!;
      });
      if (content.isEmpty) {
        setState(() {
          isEmpty = true;
        });
      }
    });
  }

  Future<void> _onRefresh() async {
    // 持续两秒
    await Future.delayed(const Duration(milliseconds: 2000), () {
      index = 1;
      _getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: content.isNotEmpty
          ? ListView(
              children: content.map(
                (item) {
                  return RankItem(
                    id: item["id"] ?? 0,
                    hot: item["hot"] ?? 0,
                    imgUrl: item["imgUrl"] ?? '',
                    title: item["title"] ?? '',
                    index: index++,
                    content_url: 'xxx',
                  );
                },
              ).toList(),
            )
          : isEmpty
              ? ListView(
                  children: const [
                    Center(
                      child: Text('当前页为空'),
                    ),
                  ],
                )
              : const SpinKitPouringHourGlass(
                  color: Color.fromRGBO(138, 135, 240, 1),
                ),
    );
  }
}
