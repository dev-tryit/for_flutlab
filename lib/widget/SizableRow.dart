import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SizableRow extends StatefulWidget {
  _SizableRowState createState() => _SizableRowState();
}

class _SizableRowState extends State<SizableRow> {
  Offset? oldGlobalPosition;

  int totalWidth = 1200;
  int leftWidth = 600;

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
              child: Text("LeftPage4"),
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
              Offset globalPosition = details.globalPosition;
              print("onHorizontalDragUpdate globalPosition:${globalPosition}");
              if (oldGlobalPosition != null) {
                int dif = (oldGlobalPosition!.dx - globalPosition.dx).toInt();
                print("onHorizontalDragUpdate dif:$dif");
                setState(() {
                  leftWidth += dif;
                });
              }
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
              child: Text("RightPage4"),
            ),
          ),
        ],
      ),
    );
  }
}
