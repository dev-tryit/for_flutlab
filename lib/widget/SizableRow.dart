import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:algoritm_flutter_web/page/TestPage.dart';
import 'package:algoritm_flutter_web/util/SizeUtil.dart';

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
    totalWidth = SizeUtil.getSizeByKey(widgetKey).width;
    leftWidth = totalWidth / 2;
    print("initState totalWidth:$totalWidth, leftWidth:$leftWidth");
  }

  void finishLoading() {
    isLoaded = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("build");

    if (!isLoaded) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        totalWidth = SizeUtil.getSizeByKey(widgetKey).width;
        leftWidth = totalWidth / 2;
        print("isLoaded totalWidth:$totalWidth, leftWidth:$leftWidth");

        finishLoading();
      });
    }

    return Row(
      children: [
        Container(
          key: widgetKey,
          width: SizeUtil.screenSize(context).width,
          height: SizeUtil.screenSize(context).width,
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
        ),
      ],
    );
  }
}
