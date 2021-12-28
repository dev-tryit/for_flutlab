import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int totalWidth = 1200;
  int leftWidth = 600;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(flex: leftWidth, child: Text("LeftPage")),
                Container(
                  width: 1,
                  height: 10000,
                  color: Colors.grey,
                ),
                Expanded(flex: totalWidth - leftWidth, child: Text("RightPage")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
