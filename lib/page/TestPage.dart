import 'package:flutter/material.dart';
import 'package:algoritm_flutter_web/widget/TrySizedBox.dart';
import 'package:algoritm_flutter_web/widget/SizableRow.dart';
import 'package:algoritm_flutter_web/widget/SizableColumn.dart';

class TestPage extends StatefulWidget {
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TrySizedBox.expand(
        child: SizableRow(
          leftWidget: SizableRow(
            leftWidget: Text("11"),
            rightWidget: Text("2"),
          ),
          rightWidget: SizableColumn(
            topWidget: Text("3"),
            bottomWidget: SizableColumn(
              topWidget: Text("4"),
              bottomWidget: Text("5"),
            ),
          ),
        ),
      ),
    );
  }
}
