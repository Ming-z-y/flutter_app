import 'package:flutter/cupertino.dart';

class Collects extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Collects();
  }
}

class _Collects extends State<Collects> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      shrinkWrap: true,
      children: [
        Text('a'),
        Text('xxx'),
        Text('xxx'),
        Text('xxx'),
        Text('xxx'),
        Text('xxx'),
        Text('xxx'),
      ],
    );
  }
}
