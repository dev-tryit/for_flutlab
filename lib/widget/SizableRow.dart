import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:algoritm_flutter_web/util/SizeUtil.dart';

class SizableRow extends StatefulWidget {
  final double devideSize;
  final Widget leftWidget;
  final Widget rightWidget;
  const SizableRow({
    this.devideSize = 8.0,
    required this.leftWidget,
    required this.rightWidget,
  });
  _SizableRowState createState() => _SizableRowState();
}

class _SizableRowState extends State<SizableRow> {
  bool isLoaded = false;

  GlobalKey widgetKey = GlobalKey();

  late double totalWidth;
  late double leftWidth;

  void initState() {
    totalWidth = SizeUtil.getSizeByKey(widgetKey).width;
    leftWidth = totalWidth / 2;
  }

  void finishLoading() {
    isLoaded = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoaded) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        totalWidth = SizeUtil.getSizeByKey(widgetKey).width;
        leftWidth = totalWidth / 2;

        finishLoading();
      });
    }

    return Container(
      key: widgetKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
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
              totalWidth = SizeUtil.getSizeByKey(widgetKey).width;
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
    );
  }
}
