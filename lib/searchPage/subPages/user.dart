import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/searchPage/generate.dart';

class User extends StatefulWidget {
  final String searchKey;
  const User({super.key, required this.searchKey});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return Generate(scope: 1, searchKey: widget.searchKey);
  }
}
