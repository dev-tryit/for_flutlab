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
  late double topHeight;

  void initState() {
    totalHeight = SizeUtil.getSizeByKey(widgetKey).height;
    topHeight = totalHeight / 2;
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
        topHeight = totalHeight / 2;

        finishLoading();
      });
    }

    return Container(
      key: widgetKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: topHeight.toInt(),
            child: widget.topWidget,
          ),
          GestureDetector(
            child: MouseRegion(
              cursor: SystemMouseCursors.resizeUpDown,
              child: Container(
                height: widget.devideSize,
                color: Colors.grey,
              ),
            ),
            onHorizontalDragUpdate: (details) {
              totalHeight = SizeUtil.getSizeByKey(widgetKey).height;
              double threadhold = widget.devideSize + 10;
              if (threadhold < details.localPosition.dy && details.localPosition.dy < totalHeight - threadhold) {
                topHeight = details.localPosition.dy;
              }
              setState(() {});
            },
          ),
          Expanded(
            flex: (totalHeight - topHeight).toInt(),
            child: widget.bottomWidget,
          ),
        ],
      ),
    );
  }
}
