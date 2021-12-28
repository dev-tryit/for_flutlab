import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SizableRow extends StatefulWidget {
  double devideSize;
  Widget leftWidget;
  Widget rightWidget;
  SizableRow({
    this.devideSize = 8.0,
    required this.leftWidget,
    required this.rightWidget,
  }) {}
  _SizableRowState createState() => _SizableRowState();
}

class _SizableRowState extends State<SizableRow> {
  bool isLoaded = false;

  GlobalKey widgetKey = GlobalKey();

  late double totalWidth;
  late double leftWidth;

  void initState() {
    totalWidth = _getSize(widgetKey).width;
    leftWidth = totalWidth / 2;
    print("initState totalWidth:$totalWidth, leftWidth:$leftWidth");
  }

  void finishLoading() {
    isLoaded = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoaded) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        totalWidth = _getSize(widgetKey).width;
        leftWidth = totalWidth / 2;
        print("isLoaded totalWidth:$totalWidth, leftWidth:$leftWidth");

        finishLoading();
      });
    }

    return Column(
      children: [
        Container(
          key: widgetKey,
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
                onHorizontalDragUpdate: (details) {
                  totalWidth = _getSize(widgetKey).width;
                  double threadhold = widget.devideSize + 10;
                  if (threadhold < details.globalPosition.dx && details.globalPosition.dx < totalWidth - threadhold) {
                    leftWidth = details.globalPosition.dx;
                  }
                  setState(() {});
                },
              ),
              Expanded(
                flex: (totalWidth - leftWidth).toInt(),
                child: widget.rightWidget,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Size _getSize(GlobalKey key) {
    if (key.currentContext != null) {
      final RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
      Size size = renderBox.size;
      return size;
    }

    return Size(0, 0);
  }
}
