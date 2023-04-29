import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../request/apis.dart';

class BumpButton extends StatefulWidget {
  final int user_id;
  final double boxHeight;
  final double fontSize;
  final double iconSize;
  // 判断是否已经被关注过
  final bool isBumped;
  const BumpButton({
    super.key,
    required this.user_id,
    required this.boxHeight,
    required this.fontSize,
    required this.iconSize,
    required this.isBumped,
  });

  @override
  State<BumpButton> createState() => _BumpButtonState();
}

class _BumpButtonState extends State<BumpButton> {
  bool isBumped = false;

  _onTap_focus() async {
    var res = await APIS.focusPeople(
      user_id: widget.user_id,
      need_focus: !isBumped,
    );
    if (res.status == 10001) {
      Fluttertoast.showToast(msg: widget.isBumped ? '取消关注成功' : '关注成功');
      setState(() {
        isBumped = !isBumped;
      });
    } else {
      Fluttertoast.showToast(msg: isBumped ? '取消关注失败' : '关注失败');
    }
  }

  _onTap() {
    setState(() {
      isBumped = !isBumped;
    });
  }

  @override
  void initState() {
    // 初始化 isBumped
    setState(() {
      isBumped = widget.isBumped;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: widget.boxHeight,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color: isBumped
            ? const Color.fromRGBO(216, 216, 216, 1)
            : const Color.fromRGBO(234, 242, 255, 1),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 65, minWidth: 60),
        child: BrnIconButton(
          name: isBumped ? '已关注' : '关注',
          direction: Direction.left,
          padding: 4,
          iconWidth: 12,
          iconWidget: Icon(
            Icons.add,
            color: isBumped
                ? Color.fromRGBO(153, 153, 153, 1)
                : Color.fromRGBO(33, 126, 229, 1),
            size: widget.iconSize,
          ),
          style: TextStyle(
            color: isBumped
                ? Color.fromRGBO(153, 153, 153, 1)
                : Color.fromRGBO(33, 126, 229, 1),
            fontSize: widget.fontSize,
          ),
          onTap: _onTap_focus,
        ),
      ),
    );
  }
}
