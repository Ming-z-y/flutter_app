import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/searchPage/generate.dart';

class Current extends StatefulWidget {
  final String searchKey;
  const Current({super.key, required this.searchKey});

  @override
  State<Current> createState() => _CurrentState();
}

class _CurrentState extends State<Current> {
  @override
  Widget build(BuildContext context) {
    return Generate(scope: 2, searchKey: widget.searchKey);
  }
}
