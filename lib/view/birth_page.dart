import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BirthPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _BirthPageState();
}

class _BirthPageState extends State<BirthPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('BirthPage'),
      ),
    );
  }

}