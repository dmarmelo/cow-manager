import 'package:cow_manager/model/animal.dart';
import 'package:cow_manager/model/birth.dart' as prefix0;
import 'package:cow_manager/repository/birth_dao.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BirthPage extends StatefulWidget {
  BirthPage({Key key, this.animal}) : super(key: key);

  final Animal animal;

  @override
  State<StatefulWidget> createState() => new _BirthPageState();
}

class _BirthPageState extends State<BirthPage> {

  final _formKey = new GlobalKey<FormState>();
  String _errorMessage;
  var dateFormat = DateFormat('yyyy-MM-dd');
  final TextEditingController _maleNumber = new TextEditingController();
  final TextEditingController _femaleNumber = new TextEditingController();
  final TextEditingController _stillbirths= new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Birth'),
      ),
      body: _showForm(),
    );
  }

  Widget _showForm() {
    return new Container(
      padding: EdgeInsets.all(16.0),
      child: new Form(
        key: _formKey,
        child: new Column(
          children: <Widget>[
            new TextFormField(
              // Male
              maxLines: 1,
              keyboardType: TextInputType.number,
              autofocus: false,
              decoration: new InputDecoration(
                labelText: 'Male',
                hintText: 'Enter a number of males...',
              ),
              validator: (value) =>
              value.isEmpty ? 'Males can\'t be empty' : null,
              controller: _maleNumber,
            ),
            new TextFormField(
              // Weighting
              maxLines: 1,
              keyboardType: TextInputType.number,
              autofocus: false,
              decoration: new InputDecoration(
                labelText: 'Female',
                hintText: 'Enter a number of females...',
              ),
              validator: (value) =>
              value.isEmpty ? 'Females can\'t be empty' : null,
              controller: _femaleNumber,
            ),
            new TextFormField(
              // Weighting
              maxLines: 1,
              keyboardType: TextInputType.number,
              autofocus: false,
              decoration: new InputDecoration(
                labelText: 'Still births',
                hintText: 'Enter a number of stills...',
              ),
              validator: (value) =>
              value.isEmpty ? 'Stills can\'t be empty' : null,
              controller: _stillbirths,
            ),
            showPrimaryButton(),
            showErrorMessage()
          ],
        ),
      ),
    );
  }

  Widget showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(50.0, 25.0, 50.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.orange,
            child: new Text('Save birth',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: validateAndSubmit,
          ),
        ));
  }

  void validateAndSubmit() {
    setState(() {
      _errorMessage = "";
    });
    try {
      var newBirth = new prefix0.Birth(
          widget.animal.electronicId,
          dateFormat.parse(new DateTime.now().toString()),
        int.parse(_maleNumber.text.trim()),
        int.parse(_femaleNumber.text.trim()),
        int.parse(_stillbirths.text.trim()),
      );
      BirthDao().create(newBirth).then((birth) {
        Navigator.pop(context);
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        _errorMessage = e.message;
        _formKey.currentState.reset();
      });
    }
  }

  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }
}
