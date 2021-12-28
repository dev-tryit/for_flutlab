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
        height: double.infinity,
        child: Row(
          children: [
            Expanded(
              flex: leftWidth,
              child: Container(
                height: double.infinity,
                color: Colors.blue,
                child: Text("LeftPage"),
              ),
            ),
            Container(
              width: 3,
              color: Colors.grey,
            ),
            Expanded(
              flex: totalWidth - leftWidth,
              child: Container(
                height: double.infinity,
                color: Colors.red,
                child: Text("RightPage"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
