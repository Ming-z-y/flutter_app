import 'package:flutter/cupertino.dart';

class Bumps extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Bumps();
  }
}

class _Bumps extends State<Bumps> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      shrinkWrap: true,
      children: [
        Text('c'),
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
