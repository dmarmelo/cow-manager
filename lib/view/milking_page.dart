import 'package:cow_manager/model/animal.dart';
import 'package:cow_manager/model/milking.dart';
import 'package:cow_manager/repository/animal_dao.dart';
import 'package:cow_manager/repository/milking_dao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MilkingPage extends StatefulWidget {
  MilkingPage({Key key, this.animal}) : super(key: key);

  final Animal animal;

  @override
  State<StatefulWidget> createState() => new _MilkingPageState();
}

class _MilkingPageState extends State<MilkingPage> {
  final _formKey = new GlobalKey<FormState>();

  final TextEditingController _milkingController = new TextEditingController();
  String _errorMessage;

  List<Milking> _milkings = new List();

  @override
  void initState() {
    _errorMessage = "";
    super.initState();

    MilkingDao().where("animalKey", widget.animal.key).then((list) {
      setState(() {
        _milkings.addAll(list);
        _milkings.sort((a, b) => a.dateTime.compareTo(b.dateTime) * -1);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Milking'),
      ),
      body: Column(
        children: <Widget>[
          _showForm(),
          ..._showShowMilkingList(),
        ],
      ),
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
              // Milking
              maxLines: 1,
              keyboardType: TextInputType.number,
              autofocus: false,
              decoration: new InputDecoration(
                labelText: 'Milking',
                hintText: 'Enter a Milking...',
              ),
              validator: (value) =>
                  value.isEmpty ? 'Milking can\'t be empty' : null,
              controller: _milkingController,
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
            child: new Text('Save Milking',
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
      this.widget.animal.lastMilking = double.parse(_milkingController.text.trim());
      AnimalDao().update(this.widget.animal);

      var newMilking = new Milking(
          widget.animal.key,
          new DateTime.now(),
          double.parse(_milkingController.text.trim())
      );
      MilkingDao().create(newMilking).then((milking) {
        Fluttertoast.showToast(msg: "Milking Added Sucessfully!", gravity: ToastGravity.BOTTOM);
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

  List<Widget> _showShowMilkingList() {
    return [
      Divider(),
      Center(
        child: Text(
          "Milking History",
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      Expanded(
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: _milkings.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 50,
              child: ListTile(
                title: Text("${_milkings[index].amount.toString()}ml"),
                trailing: Text(_milkings[index].dateTime.toString()),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
      ),
    ];
  }
}
