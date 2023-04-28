import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FocusItem extends StatefulWidget {
  final int user_id;
  final String avatar;
  final String nick_name;
  final bool isFull;
  const FocusItem({
    super.key,
    required this.isFull,
    required this.user_id,
    required this.avatar,
    required this.nick_name,
  });

  @override
  State<StatefulWidget> createState() => _FocusItem();
}

class _FocusItem extends State<FocusItem> {
  @override
  Widget build(BuildContext context) {
    return !widget.isFull
        ? SizedBox(
            width: 60,
            height: 100,
            child: Column(
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  ),
                  child: CachedNetworkImage(imageUrl: widget.avatar),
                ),
                Center(
                    child: Text(
                  widget.nick_name,
                  overflow: TextOverflow.ellipsis,
                ))
              ],
            ),
          )
        : Container(
            width: 60,
            height: 100,
            child: Column(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  margin: EdgeInsets.only(top: 5),
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(166, 193, 243, 1),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                const Center(
                  child: Text(
                    '全部',
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          );
  }
}
