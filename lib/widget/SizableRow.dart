import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SizableRow extends StatefulWidget {
  _SizableRowState createState() => _SizableRowState();
}

class _SizableRowState extends State<SizableRow> {
  Offset? oldGlobalPosition;

  bool isLoaded = false;

  late double totalWidth;
  late double leftWidth;

  void initState() {
    Future(() {
      onLoad();
    });
  }

  void onLoad() {
    isLoaded = true;
    totalWidth = MediaQuery.of(context).size.width;
    leftWidth = totalWidth / 2;
    print("totalWidth : $totalWidth, leftWidth : $leftWidth, ");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return !isLoaded
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            height: double.infinity,
            child: Row(
              children: [
                Expanded(
                  flex: leftWidth.toInt(),
                  child: Container(
                    height: double.infinity,
                    color: Colors.blue,
                    child: Text("LeftPage15"),
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
                    print("onHorizontalDragUpdate details.globalPosition.dx:${details.globalPosition.dx}");
                    leftWidth += details.globalPosition.dx;
                    setState(() {});
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
                    child: Text("RightPage8"),
                  ),
                ),
              ],
            ),
          );
  }
}
