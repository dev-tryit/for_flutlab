import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("LeftPage"),
        Divider(thickness: 1),
        Text("RightPage"),
      ],
    );
  }
}
