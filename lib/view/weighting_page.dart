import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WeightingPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _WeightingPageState();
}

class _WeightingPageState extends State<WeightingPage> {

  @override
  Widget build(BuildContext context) {
    /* TODO
        Campo para inserir as pesagens (NumberField - Button)
        Listas das pesagens, por ordem cronológicamente inversa (ListView)
     */
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Weighting'),
      ),
      body: Text('WeightingPage'),
    );
  }
}