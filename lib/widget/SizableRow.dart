import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SizableRow extends StatefulWidget {
  _SizableRowState createState() => _SizableRowState();
}

class _SizableRowState extends State<SizableRow> {
  bool isLoaded = false;

  Offset? oldGlobalPosition;
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
                    child: Text("LeftPage10"),
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
                      int dif = (globalPosition.dx - oldGlobalPosition!.dx).toInt();
                      print("onHorizontalDragUpdate dif:$dif");
                      leftWidth += dif;
                      setState(() {});
                    }
                    oldGlobalPosition = globalPosition;
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
