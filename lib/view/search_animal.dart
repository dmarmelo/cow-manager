import 'package:cow_manager/chip_field/ChipFormField.dart';
import 'package:flutter/material.dart';

class SearchAnimalPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SearchAnimalPageState();
}

class _SearchAnimalPageState extends State<SearchAnimalPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Cow Manager'),
        ),
        body: _showSearch());
  }

  Widget _showSearch() {
    // create a new ChipFormField widget to get an animal identifier
    // use _chipFormField.chip to get the animal identifier whenever needed
    //
    ChipFormField _chipFormField = ChipFormField(context, 'HC-06', (chip) {
      print('CHIP: ' + chip);
    });

    return _chipFormField;
  }
}
