import 'package:cow_manager/chip_field/ChipFormField.dart';
import 'package:cow_manager/repository/animal_dao.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../view/animal_profile.dart';

class SearchAnimal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SearchAnimalState();
}

class _SearchAnimalState extends State<SearchAnimal> {
  ChipFormField _chipFormField;

  @override
  void initState() {
    super.initState();

    // create a new ChipFormField widget to get an animal identifier
    // use _chipFormField.chip to get the animal identifier whenever needed
    //
    _chipFormField = ChipFormField(context, 'HC-06', TextEditingController(), (chip) {
      print('CHIP: ' + chip);
    });
  }

  @override
  Widget build(BuildContext context) {
    /*return new Scaffold(
        appBar: new AppBar(
          title: new Text('Search Animal',style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: _showChipSearch()
    );*/
    return _showChipSearch();
  }

  Widget _showChipSearch() {
    return Container(
      child: Column(
        children: <Widget>[
          _chipFormField,
          Padding(
              padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
              child: SizedBox(
                height: 40.0,
                child: new RaisedButton(
                  elevation: 5.0,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  color: Colors.orange,
                  child: new Text("Search",
                      style:
                          new TextStyle(fontSize: 20.0, color: Colors.white)),
                  onPressed: () => _search(),
                ),
              )),
        ],
      ),
    );
  }

  void _search() {
    var chip = _chipFormField.chip;

    AnimalDao().where("id eletrónica", chip).then((results) {
      if (results.length > 0) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AnimalProfilePage(animal: results[0])));
      } else {
        Fluttertoast.showToast(
            msg: "Animal Not Found", gravity: ToastGravity.CENTER);
      }
    });
  }
}
