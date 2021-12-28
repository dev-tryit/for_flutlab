import 'package:flutter/material.dart';
import 'package:algoritm_flutter_web/widget/TrySizedBox.dart';
import 'package:algoritm_flutter_web/widget/SizableRow.dart';

class TestPage extends StatefulWidget {
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TrySizedBox.expand(
        child: Text("test"),
      ),
    );
  }
  /*
  SizableRow(
          leftWidget: leftWidget(),
          rightWidget: rightWidget(),
        )
*/

  Widget leftWidget() {
    return Container(
      height: double.infinity,
      color: Colors.red,
      child: Text("leftWidget8"),
    );
  }

  Widget rightWidget() {
    return Container(
      height: double.infinity,
      color: Colors.red,
      child: Text("rightWidget8"),
    );
  }
}
