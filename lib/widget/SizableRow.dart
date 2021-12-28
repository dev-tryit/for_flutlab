import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SizableRow extends StatefulWidget {
  _SizableRowState createState() => _SizableRowState();
}

class _SizableRowState extends State<SizableRow> {
  num totalWidth = 1200;
  num leftWidth = 600;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: Row(
        children: [
          Expanded(
            flex: leftWidth.toInt(),
            child: Container(
              height: double.infinity,
              color: Colors.blue,
              child: Text("LeftPage1"),
            ),
          ),
          GestureDetector(
            child: MouseRegion(
              cursor: SystemMouseCursors.resizeLeftRight,
              child: Container(
                width: 8,
                color: Colors.grey,
              ),
            ),
            onHorizontalDragStart: (details) {
              print("onHorizontalDragStart details:$details");
            },
            onHorizontalDragUpdate: (details) {
              print("onHorizontalDragUpdate details:$details");
              setState(() {
                leftWidth += details.delta.dx;
              });
            },
            onHorizontalDragEnd: (details) {
              print("onHorizontalDragEnd details:$details");
            },
          ),
          Expanded(
            flex: (totalWidth - leftWidth).toInt(),
            child: Container(
              height: double.infinity,
              color: Colors.red,
              child: Text("RightPage2"),
            ),
          ),
        ],
      ),
    );
  }
}
