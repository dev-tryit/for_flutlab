import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:algoritm_flutter_web/util/SizeUtil.dart';

class SizableColumn extends StatefulWidget {
  final double devideSize;
  final Widget topWidget;
  final Widget bottomWidget;
  const SizableColumn({
    this.devideSize = 8.0,
    required this.topWidget,
    required this.bottomWidget,
  });
  _SizableColumnState createState() => _SizableColumnState();
}

class _SizableColumnState extends State<SizableColumn> {
  bool isLoaded = false;

  GlobalKey widgetKey = GlobalKey();

  late double totalHeight;
  late double leftHeight;

  void initState() {
    totalHeight = SizeUtil.getSizeByKey(widgetKey).height;
    leftHeight = totalHeight / 2;
  }

  void finishLoading() {
    isLoaded = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoaded) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        totalHeight = SizeUtil.getSizeByKey(widgetKey).height;
        leftHeight = totalHeight / 2;

        finishLoading();
      });
    }

    return Container(
      key: widgetKey,
      child: Column(
        children: [
          Expanded(
            flex: leftHeight.toInt(),
            child: widget.topWidget,
          ),
          GestureDetector(
            child: MouseRegion(
              cursor: SystemMouseCursors.resizeLeftRight,
              child: Container(
                height: widget.devideSize,
                color: Colors.grey,
              ),
            ),
            onHorizontalDragUpdate: (details) {
              totalHeight = SizeUtil.getSizeByKey(widgetKey).height;
              double threadhold = widget.devideSize + 10;
              if (threadhold < details.globalPosition.dy && details.globalPosition.dy < totalHeight - threadhold) {
                leftHeight = details.globalPosition.dy;
              }
              setState(() {});
            },
          ),
          Expanded(
            flex: (totalHeight - leftHeight).toInt(),
            child: widget.bottomWidget,
          ),
        ],
      ),
    );
  }
}
