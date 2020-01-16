import 'package:cow_manager/chip_field/ChipFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Birth extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _BirthState();
}

class _BirthState extends State<Birth> {
  ChipFormField _chipFormFieldMother;
  ChipFormField _chipFormFieldFather;

  @override
  void initState() {
    super.initState();

    _chipFormFieldMother = ChipFormField(context, 'HC-06', TextEditingController(), (chip) {
      print('CHIP: ' + chip);
    });

    _chipFormFieldFather = ChipFormField(context, 'HC-06', TextEditingController(), (chip) {
      print('CHIP: ' + chip);
    });
  }

  @override
  Widget build(BuildContext context) {
    /* TODO
        Formulário com campos que estão definidos na classe Birth
        Pomos também o pai??
     */
    return new Scaffold(
      /*appBar: new AppBar(
        title: new Text('BirthPage'),
      ),*/
      body: Container(
        child: Column(
          children: <Widget>[
            _chipFormFieldMother,
            _chipFormFieldFather
          ],
        ),
      )
    );
  }

}