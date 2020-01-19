import 'package:cow_manager/model/animal.dart';
import 'package:cow_manager/model/milking.dart';
import 'package:cow_manager/repository/animal_dao.dart';
import 'package:cow_manager/repository/milking_dao.dart';
import 'package:cow_manager/view/animal_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class MilkingPage extends StatefulWidget {
  MilkingPage({Key key, this.animal}) : super(key: key);

  final Animal animal;


  @override
  State<StatefulWidget> createState() => new _MilkingPageState();
}

class _MilkingPageState extends State<MilkingPage> {

  final _formKey = new GlobalKey<FormState>();
  var dateFormat = DateFormat('yyyy-MM-dd');
  final TextEditingController _milkingController = new TextEditingController();
  String _errorMessage;



  @override
  void initState() {
    _errorMessage = "";
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    /* TODO
        Campo para inserir as aleitações (NumberField - Button)
        Listas das aleitações, por ordem cronológicamente inversa (ListView)
     */
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Milking'),
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
            children: <Widget>[
              new TextFormField(
                // Milking
                maxLines: 1,
                keyboardType: TextInputType.text,
                autofocus: false,
                decoration: new InputDecoration(
                  labelText: 'Milking',
                  hintText: 'Enter a value milking...',
                ),
                validator: (value) =>
                value.isEmpty ? 'milking can\'t be empty' : null,
                controller: _milkingController,
              ),
              showPrimaryButton(),
              showErrorMessage()
        ])
       )
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
            child: new Text('Save amount',
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
        this.widget.animal.amount =  double.parse(_milkingController.text.trim());

        var newMilking = new Milking(
             widget.animal.electronicId,
             dateFormat.parse(new DateTime.now().toString()),
             double.parse(_milkingController.text.trim()));
        AnimalDao().update(this.widget.animal);
        MilkingDao().create(newMilking).then((milking) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AnimalProfilePage(animal: widget.animal)));
        });

        Navigator.pop(context);
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