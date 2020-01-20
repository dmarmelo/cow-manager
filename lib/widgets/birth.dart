import 'package:cow_manager/chip_field/ChipFormField.dart';
import 'package:cow_manager/repository/animal_dao.dart';
import 'package:cow_manager/view/birth_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Birth extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => new _BirthState();
}

class _BirthState extends State<Birth> {
  ChipFormField _chipFormFieldMother;


  @override
  void initState() {
    super.initState();

    _chipFormFieldMother = ChipFormField(context, 'HC-06', TextEditingController(), (chip) {
      print('CHIP: ' + chip);
    });

  }

  @override
  Widget build(BuildContext context) {
    /* TODO
        Formulário com campos que estão definidos na classe Birth
        Incrementar os ciclos de reprodução do animal
     */
    return new Scaffold(
      /*appBar: new AppBar(
        title: new Text('BirthPage'),
      ),*/
      body: Container(
        child: Column(
          children: <Widget>[
            _chipFormFieldMother,
            Padding(
                padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                child: SizedBox(
                  height: 40.0,
                  child: new RaisedButton(
                    elevation: 5.0,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.orange,
                    child: new Text("Birth",
                        style:
                        new TextStyle(fontSize: 20.0, color: Colors.white)),
                    onPressed: () => _search(),
                  ),
                )),
          ],
        ),
      )
    );
  }

  void _search() {
    var chipMother = _chipFormFieldMother.chip;

    AnimalDao().where("id eletrónica", chipMother).then((results) {
      if (results.length > 0) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BirthPage(animal: results[0])));
      } else {
          Fluttertoast.showToast(
          msg: "Animal Not Found", gravity: ToastGravity.CENTER);
      }
    });
  }

}