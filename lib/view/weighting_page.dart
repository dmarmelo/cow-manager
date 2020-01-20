import 'package:cow_manager/model/animal.dart';
import 'package:cow_manager/model/weighting.dart';
import 'package:cow_manager/repository/animal_dao.dart';
import 'package:cow_manager/repository/weighting_dao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WeightingPage extends StatefulWidget {
  WeightingPage({Key key, this.animal}) : super(key: key);

  final Animal animal;

  @override
  State<StatefulWidget> createState() => new _WeightingPageState();
}

class _WeightingPageState extends State<WeightingPage> {
  final _formKey = new GlobalKey<FormState>();

  final TextEditingController _weightingController = new TextEditingController();
  String _errorMessage;

  List<Weighting> _weightings = new List();

  @override
  void initState() {
    _errorMessage = "";
    super.initState();

    WeightingDao().where("animalKey", widget.animal.key).then((list) {
      setState(() {
        _weightings.addAll(list);
        _weightings.sort((a, b) => a.dateTime.compareTo(b.dateTime) * -1);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Weighting'),
      ),
      body: Column(
        children: <Widget>[
          _showForm(),
          ..._showShowWeightingList(),
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
              // Weighting
              maxLines: 1,
              keyboardType: TextInputType.number,
              autofocus: false,
              decoration: new InputDecoration(
                labelText: 'Weighting',
                hintText: 'Enter a Weight...',
              ),
              validator: (value) =>
                  value.isEmpty ? 'Weighting can\'t be empty' : null,
              controller: _weightingController,
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
          child: new Text('Save Weight',
              style: new TextStyle(fontSize: 20.0, color: Colors.white)),
          onPressed: validateAndSubmit,
        ),
      ),
    );
  }

  void validateAndSubmit() {
    setState(() {
      _errorMessage = "";
    });
    try {
      this.widget.animal.lastWeight = double.parse(_weightingController.text.trim());
      AnimalDao().update(this.widget.animal);

      var newWeighting = new Weighting(
          widget.animal.key,
          new DateTime.now(),
          double.parse(_weightingController.text.trim())
      );
      WeightingDao().create(newWeighting).then((weighting) {
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

  List<Widget> _showShowWeightingList() {
    return [
      Divider(),
      Center(
        child: Text(
          "Weighting History",
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      Expanded(
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: _weightings.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 50,
              child: ListTile(
                title: Text("${_weightings[index].weight.toString()}kg"),
                trailing: Text(_weightings[index].dateTime.toString()),
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
