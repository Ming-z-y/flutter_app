import 'package:flutter/material.dart';

class MessageItem extends StatefulWidget {
  const MessageItem({super.key});

  @override
  State<MessageItem> createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      alignment: Alignment.center,
      color: Colors.white,
      child: ListTile(
        title: Text('消息通知: 1'),
        leading: Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
              color: Color.fromRGBO(217, 217, 217, 1),
              borderRadius: BorderRadius.all(Radius.circular(25))),
        ),
        subtitle: const Text('xxxxxxxxxxxxxxxxxxx'),
        trailing: Column(children: [
          const Text('昨天'),
          const SizedBox(
            height: 5,
          ),
          Container(
            width: 18,
            height: 18,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(255, 90, 90, 1),
              borderRadius: BorderRadius.all(Radius.circular(9.0)),
            ),
            child: Center(
                child: Text(
              '1',
              style: TextStyle(color: Colors.white),
            )),
          )
        ]),
      ),
    );
  }
}
