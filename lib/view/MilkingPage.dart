import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MilkingPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _MilkingPageState();
}

class _MilkingPageState extends State<MilkingPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('MilkingPage'),
      ),
    );
  }

}