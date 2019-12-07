import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewAnimalPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _NewAnimalPageState();
}

class _NewAnimalPageState extends State<NewAnimalPage> {
  final _formKey = new GlobalKey<FormState>();

  String _electronicId;
  String _earring;
  String _breed;
  DateTime _birth;
  String _gender = "Macho";
  String _profile;
  String _effective;
  String _lot;
  String _park;
  int _reproductionCycles;
  String _pathology;
  double _weight;
  String _userId;

  String _errorMessage;

  @override
  void initState() {
    _errorMessage = "";
    super.initState();
  }

  // Check if form is valid before perform login or signup
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
    });
    if (validateAndSave()) {
      String userId = "";
      try {

      } catch (e) {
        print('Error: $e');
        setState(() {
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Cow Manager'),
      ),
      body: _showForm(),
    );
  }

  Widget _showForm() {
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              new TextFormField( // Earring
                maxLines: 1,
                keyboardType: TextInputType.text,
                autofocus: false,
                decoration: new InputDecoration(
                  hintText: "Earring",
                ),
                validator: (value) =>
                    value.isEmpty ? 'Earring can\'t be empty' : null,
                onSaved: (value) => _earring = value.trim(),
              ),
              new TextFormField( // Breed
                maxLines: 1,
                keyboardType: TextInputType.text,
                autofocus: false,
                decoration: new InputDecoration(
                  hintText: "Breed",
                ),
                validator: (value) =>
                value.isEmpty ? 'Breed can\'t be empty' : null,
                onSaved: (value) => _breed = value.trim(),
              ),
              new TextFormField( // Birth
                maxLines: 1,
                keyboardType: TextInputType.datetime,
                autofocus: false,
                decoration: new InputDecoration(
                  hintText: "Birth",
                ),
                validator: (value) =>
                // TODO validate date
                value.isEmpty ? 'Birth can\'t be empty' : null,
                onSaved: (value) => _birth = DateFormat('yyyy-MM-dd').parse(value.trim()),
              ),
              new Row( //Gender
                children: <Widget>[
                  new Radio(
                    value: 'Macho',
                    groupValue: _gender,
                    onChanged: (newValue) => setState(() {
                      _gender = newValue;
                    }),
                  ),
                  new Text('Male'),
                  new Radio(
                    value: 'Femea',
                    groupValue: _gender,
                    onChanged: (newValue) => setState(() {
                      _gender = newValue;
                    }),
                  ),
                  new Text('Female'),
                ],
              ),
              new TextFormField( // Profile
                maxLines: 1,
                keyboardType: TextInputType.text,
                autofocus: false,
                decoration: new InputDecoration(
                  hintText: "Profile",
                ),
                validator: (value) =>
                value.isEmpty ? 'Profile can\'t be empty' : null,
                onSaved: (value) => _profile = value.trim(),
              ),
              new TextFormField( // Effective
                maxLines: 1,
                keyboardType: TextInputType.text,
                autofocus: false,
                decoration: new InputDecoration(
                  hintText: "Effective",
                ),
                validator: (value) =>
                value.isEmpty ? 'Effective can\'t be empty' : null,
                onSaved: (value) => _effective = value.trim(),
              ),
              new TextFormField( // Lot
                maxLines: 1,
                keyboardType: TextInputType.text,
                autofocus: false,
                decoration: new InputDecoration(
                  hintText: "Lot",
                ),
                validator: (value) =>
                value.isEmpty ? 'Lot can\'t be empty' : null,
                onSaved: (value) => _lot = value.trim(),
              ),
              new TextFormField( // Park
                maxLines: 1,
                keyboardType: TextInputType.text,
                autofocus: false,
                decoration: new InputDecoration(
                  hintText: "Park",
                ),
                validator: (value) =>
                value.isEmpty ? 'Park can\'t be empty' : null,
                onSaved: (value) => _park = value.trim(),
              ),
              new TextFormField( // ReproductionCycles
                maxLines: 1,
                keyboardType: TextInputType.numberWithOptions(),
                autofocus: false,
                decoration: new InputDecoration(
                  hintText: "ReproductionCycles",
                ),
                validator: (value) =>
                value.isEmpty ? 'ReproductionCycles can\'t be empty' : null,
                onSaved: (value) => _reproductionCycles = int.parse(value.trim()),
              ),
              new TextFormField( // Pathology
                maxLines: 1,
                keyboardType: TextInputType.text,
                autofocus: false,
                decoration: new InputDecoration(
                  hintText: "Pathology",
                ),
                validator: (value) =>
                value.isEmpty ? 'Pathology can\'t be empty' : null,
                onSaved: (value) => _pathology = value.trim(),
              ),
              new TextFormField( // Weight
                maxLines: 1,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                autofocus: false,
                decoration: new InputDecoration(
                  hintText: "Weight",
                ),
                validator: (value) =>
                value.isEmpty ? 'Weight can\'t be empty' : null,
                onSaved: (value) => _weight = double.parse(value.trim()),
              ),
              showPrimaryButton(),
              showErrorMessage(),
            ],
          ),
        ));
  }

  Widget showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.orange,
            child: new Text('Create animal',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: validateAndSubmit,
          ),
        ));
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
