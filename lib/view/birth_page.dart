import 'package:cow_manager/model/animal.dart';
import 'package:cow_manager/model/birth.dart';
import 'package:cow_manager/repository/animal_dao.dart';
import 'package:cow_manager/repository/birth_dao.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// [Widget] da página de inserção de partos dos animais.
class BirthPage extends StatefulWidget {
  /// Cria uma instância do [Widget]. Recebe o [Animal] a inserir e mostrar os partos.
  BirthPage({Key key, this.animal}) : super(key: key);

  final Animal animal;

  @override
  State<StatefulWidget> createState() => new _BirthPageState();
}

/// Estado do [Widget] da página de inserção de partos dos animais, onde é
/// possível inserir os partos e visualizar uma lista de todos os partos
/// já registados por ordem cronológicamente inversa.
class _BirthPageState extends State<BirthPage> {

  final _formKey = new GlobalKey<FormState>();
  String _errorMessage = "";

  final TextEditingController _maleNumber = new TextEditingController();
  final TextEditingController _femaleNumber = new TextEditingController();
  final TextEditingController _stillbirths= new TextEditingController();

  /// Lista de partos do animal.
  List<Birth> _births = new List();

  @override
  void initState() {
    _errorMessage = "";
    super.initState();

    BirthDao().where("animalKey", widget.animal.key).then((list) {
      setState(() {
        _births.addAll(list);
        _births.sort((a, b) => a.dateTime.compareTo(b.dateTime) * -1);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Birth'),
      ),
      body: Column(
        children: <Widget>[
          _showForm(),
          ..._showShowBirthList(),
        ],
      ),
    );
  }

  /// Constrói e retorna o [Widget] do formulário de inserção de partos.
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
                labelText: 'Males',
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
                labelText: 'Females',
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

  /// Constrói e retorna o [Widget] do botão para inserir ao parto.
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
      ),
    );
  }

  /// Valida o formulário, insere o parto na base de dados do Firebase e
  /// incrementa os ciclos de reprodução do objeto do animal.
  void validateAndSubmit() {
    setState(() {
      _errorMessage = "";
    });
    try {
      this.widget.animal.reproductionCycles++;
      AnimalDao().update(this.widget.animal);

      var newBirth = new Birth(
          widget.animal.key,
          new DateTime.now(),
        int.parse(_maleNumber.text.trim()),
        int.parse(_femaleNumber.text.trim()),
        int.parse(_stillbirths.text.trim()),
      );
      BirthDao().create(newBirth).then((birth) {
        Fluttertoast.showToast(msg: "Birth Added Sucessfully!", gravity: ToastGravity.BOTTOM);
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

  /// Constrói e retorna o [Widget] para mostrar a mensagem de erro.
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
    }
    else {
      return new Container(
        height: 0.0,
      );
    }
  }

  /// Constrói e retorna a [List] de [Widget]'s que constituem a lista para
  /// visualização de todas os partos do animal registados.
  List<Widget> _showShowBirthList() {
    return [
      Divider(),
      Center(
        child: Text(
          "Birth History",
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      Expanded(
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: _births.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              //height: 50,
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Males: ${_births[index].maleNumber.toString()}"),
                    Text("Females: ${_births[index].femaleNumber.toString()}"),
                    Text("Still Births: ${_births[index].stillbirths.toString()}")
                  ],
                ),
                trailing: Text(_births[index].dateTimeStr),
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
