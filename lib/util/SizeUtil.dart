import 'package:flutter/material.dart';

class SizeUtil {
  static Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static Size getSizeByContext(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    Size size = renderBox.size;
    return size;
  }

  static Size getSizeByKey(GlobalKey key) {
    if (key.currentContext != null) {
      return getSizeByContext(key.currentContext!);
    }

    return Size(0, 0);
  }
}
