import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CommentsItem extends StatefulWidget {
  final int comment_id;
  final int from_user_id;
  final String nick_name;
  final String avatar;
  final String content;
  final String at_time;
  final String ip_territory;
  final int liked_num;
  const CommentsItem({
    super.key,
    required this.comment_id,
    required this.from_user_id,
    required this.nick_name,
    required this.avatar,
    required this.content,
    required this.at_time,
    required this.ip_territory,
    required this.liked_num,
  });

  @override
  State<CommentsItem> createState() => _CommentsItemState();
}

class _CommentsItemState extends State<CommentsItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      margin: EdgeInsets.only(top: 5),
      // child: Column(
      //   children: [
      //     Container(
      //       child: Row(
      //         children: [
      //           Container(
      //             width: 35,
      //             clipBehavior: Clip.hardEdge,
      //             decoration: const BoxDecoration(
      //               borderRadius: BorderRadius.all(Radius.circular(16.0)),
      //             ),
      //             child: CachedNetworkImage(
      //               imageUrl:
      //                   'https://c-ssl.duitang.com/uploads/blog/202206/26/20220626195022_9c310.jpeg',
      //               errorWidget: (context, url, error) {
      //                 return Text('出错了');
      //               },
      //               progressIndicatorBuilder:
      //                   (context, url, downloadProgress) =>
      //                       LinearProgressIndicator(
      //                 value: downloadProgress.progress,
      //               ),
      //             ),
      //           ),
      //           const SizedBox(width: 10),
      //           Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Text(
      //                 'blus',
      //                 style: TextStyle(fontSize: 14),
      //               ),
      //               SizedBox(height: 5),
      //               Text(
      //                 '这衣服真好看',
      //                 style: TextStyle(fontSize: 16),
      //               ),
      //             ],
      //           )
      //         ],
      //       ),
      //     ),
      //     Container(
      //       padding: EdgeInsets.only(left: 50),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Text('昨天 18: 03'),
      //           Row(
      //             children: const [
      //               Icon(
      //                 Icons.arrow_drop_down_circle,
      //                 size: 13,
      //               ),
      //               Icon(
      //                 Icons.favorite,
      //                 color: Colors.red,
      //                 size: 13,
      //               )
      //             ],
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 35,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
            child: CachedNetworkImage(
              imageUrl:
                  'https://c-ssl.duitang.com/uploads/blog/202206/26/20220626195022_9c310.jpeg',
              errorWidget: (context, url, error) {
                return Text('出错了');
              },
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  LinearProgressIndicator(
                value: downloadProgress.progress,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.nick_name,
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 3),
              Text(
                widget.content,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 3),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${widget.at_time} ${widget.ip_territory}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(153, 153, 153, 1),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_drop_down_circle,
                          size: 13,
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 13,
                        ),
                        SizedBox(width: 8),
                        Text('${widget.liked_num}',
                            style: TextStyle(fontSize: 10))
                      ],
                    ),
                  ],
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
