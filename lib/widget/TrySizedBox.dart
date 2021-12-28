import 'package:flutter/material.dart';

enum TrySizedBoxSizeType { general, expand, shrink }

class TrySizedBox extends StatelessWidget {
  double? width;
  double? height;
  Widget child;
  Alignment alignment;
  TrySizedBoxSizeType sizeType;

  TrySizedBox(this.width, this.height, {required this.child, this.alignment = Alignment.center}) : sizeType = TrySizedBoxSizeType.general;
  TrySizedBox.expand({required this.child, this.alignment = Alignment.center}) : sizeType = TrySizedBoxSizeType.expand;
  TrySizedBox.shrink({required this.child, this.alignment = Alignment.center}) : sizeType = TrySizedBoxSizeType.shrink;

  @override
  Widget build(BuildContext context) {
    if (sizeType == TrySizedBoxSizeType.expand) {
      return Container(
        alignment: alignment,
        child: SizedBox.expand(
          child: child,
        ),
      );
    }

    if (sizeType == TrySizedBoxSizeType.shrink) {
      return Container(
        alignment: alignment,
        child: SizedBox.shrink(
          child: child,
        ),
      );
    }

    return Container(
      alignment: alignment,
      child: Container(
        child: child,
        width: width,
        height: height,
      ),
    );
  }
}
