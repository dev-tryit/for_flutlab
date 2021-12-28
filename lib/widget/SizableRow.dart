import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SizableRow extends StatefulWidget {
  double devideSize;
  Widget leftWidget;
  Widget rightWidget;
  SizableRow({this.devideSize = 8.0, required this.leftWidget, required this.rightWidget}) {}
  _SizableRowState createState() => _SizableRowState();
}

class _SizableRowState extends State<SizableRow> {
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
                  child: widget.leftWidget,
                ),
                GestureDetector(
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeLeftRight,
                    child: Container(
                      width: widget.devideSize,
                      color: Colors.grey,
                    ),
                  ),
                  onHorizontalDragStart: (details) {
                    print("onHorizontalDragStart details:$details");
                  },
                  onHorizontalDragUpdate: (details) {
                    print("onHorizontalDragUpdate details.globalPosition.dx:${details.globalPosition.dx}");
                    totalWidth = MediaQuery.of(context).size.width;
                    if (widget.devideSize < details.globalPosition.dx && details.globalPosition.dx < totalWidth - devideSize) {
                      leftWidth = details.globalPosition.dx;
                    }
                    setState(() {});
                  },
                  onHorizontalDragEnd: (details) {
                    print("onHorizontalDragEnd details:$details");
                  },
                ),
                Expanded(
                  flex: (totalWidth - leftWidth).toInt(),
                  child: widget.rightWidget,
                ),
              ],
            ),
          );
  }
}
