import 'package:cow_manager/chip_field/ChipFormField.dart';
import 'package:cow_manager/model/animal.dart';
import 'package:cow_manager/repository/animal_dao.dart';
import 'package:cow_manager/view/animal_profile.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

/// [Widget] de criação de um novo animal.
class NewAnimal extends StatefulWidget {
  /// Cria uma instância do [Widget]. Recebe o [userId] do utilizador autenticado.
  NewAnimal({Key key, this.userId}) : super(key: key);

  final String userId;

  @override
  State<StatefulWidget> createState() => new _NewAnimalState();
}

/// Estado do [Widget] de criação de um novo animal, onde é gerido o formulário
/// de introdução dos dados referentes ao animal e é efetuada a inserção
/// do novo animal na base de dados do Firebase.
class _NewAnimalState extends State<NewAnimal> {
  final _formKey = new GlobalKey<FormState>();

  var dateFormat = DateFormat('yyyy-MM-dd');
  ChipFormField _chipFormField;

  final TextEditingController _earringController = new TextEditingController();
  final TextEditingController _breedController = new TextEditingController();
  final TextEditingController _birthController = new TextEditingController();
  String _gender = "Macho";
  final TextEditingController _profileController = new TextEditingController();
  final TextEditingController _effectiveController = new TextEditingController();
  final TextEditingController _lotController = new TextEditingController();
  final TextEditingController _parkController = new TextEditingController();
  final TextEditingController _pathologyController = new TextEditingController();

  String _errorMessage;

  @override
  void initState() {
    _errorMessage = "";
    super.initState();

    _chipFormField = ChipFormField(context, 'HC-06', (chip) {
      print('CHIP: ' + chip);
    });
  }

  /// Verifica se os dados inseridos no formulário são válidos e guarda o seu
  /// estado caso se verifique a sua validade.
  /// Na validação é verificado se o animal já existe na base de dados do Firebase.
  Future<bool> validateAndSave() async {
    final form = _formKey.currentState;
    if (form.validate() && _chipFormField.chip.length > 0) {
      var animals = await AnimalDao().where("id eletrónica", _chipFormField.chip);
      if (animals.length > 0) {
        setState(() {
          _errorMessage = "Already exists one animal with this eletronic identifier!";
        });
        return false;
      }
      form.save();
      return true;
    }
    return false;
  }

  /// Valida o formulário e efetua a submissão, inserindo assim o novo animal
  /// na base de dados do Firebase. Depois de o animal ter sido inserido com
  /// sucesso é feito reset ao formulário e é aberta a página de perfil do
  /// novo animal.
  Future validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
    });
    if (await validateAndSave()) {
      try {
        var newAnimal = new Animal(
            _chipFormField.chip,
            _earringController.text.trim(),
            _breedController.text.trim(),
            Animal.dateFormatter.parse(_birthController.text.trim()),
            _gender,
            _profileController.text.trim(),
            _effectiveController.text.trim(),
            _lotController.text.trim(),
            _parkController.text.trim(),
            0,
            _pathologyController.text.trim(),
            0.0,
            0.0,
            widget.userId);

        AnimalDao().create(newAnimal).then((animal) {
          resetForm();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AnimalProfilePage(animal: animal)));
        });

      } catch (e) {
        print('Error: $e');
        setState(() {
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }

  /// Limpa os dados do formulário.
  void resetForm() {
    setState(() {
      // Flutter form reset is not working properly...
      // It does not work after validate() or save() have been called.
      //_formKey.currentState.reset();

      _earringController.text = "";
      _breedController.text = "";
      _birthController.text = "";
      _gender = "Macho";
      _profileController.text = "";
      _effectiveController.text = "";
      _lotController.text = "";
      _parkController.text = "";
      _pathologyController.text = "";

      _errorMessage = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showForm();
  }

  /// Constrói e retorna o [Widget] com o formulário para inserção do
  /// novo animal, a mensagem de erro e o botão para submeter o formulário.
  Widget _showForm() {
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            children: <Widget>[
              _chipFormField,
              new TextFormField( // Earring
                maxLines: 1,
                keyboardType: TextInputType.text,
                autofocus: false,
                decoration: new InputDecoration(
                  labelText: 'Animal Earring',
                  hintText: 'Enter animal Earring...',
                ),
                validator: (value) =>
                    value.isEmpty ? 'Earring can\'t be empty' : null,
                controller: _earringController,
              ),
              new TextFormField( // Breed
                maxLines: 1,
                keyboardType: TextInputType.text,
                autofocus: false,
                decoration: new InputDecoration(
                  labelText: 'Animal Breed',
                  hintText: 'Enter animal Breed...',
                ),
                validator: (value) =>
                    value.isEmpty ? 'Breed can\'t be empty' : null,
                controller: _breedController,
              ),
              new DateTimeField( // Birth Date
                format: Animal.dateFormatter,
                decoration: new InputDecoration(
                  labelText: 'Animal Birth Date',
                  hintText: 'Enter animal Birth Date...',
                ),
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                },
                validator: (value) =>
                    value == null ? 'Birth Date can\'t be empty' : null,
                controller: _birthController,
              ),
              new Padding(padding: new EdgeInsets.all(8.0)),
              new Text("Select animal Gender:"),
              new Row( // Gender
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
                  labelText: 'Animal Profile',
                  hintText: 'Enter animal Profile...',
                ),
                validator: (value) =>
                    value.isEmpty ? 'Profile can\'t be empty' : null,
                controller: _profileController,
              ),
              new TextFormField( // Effective
                maxLines: 1,
                keyboardType: TextInputType.text,
                autofocus: false,
                decoration: new InputDecoration(
                  labelText: 'Animal Effective',
                  hintText: 'Enter animal Effective...',
                ),
                validator: (value) =>
                    value.isEmpty ? 'Effective can\'t be empty' : null,
                controller: _effectiveController,
              ),
              new TextFormField( // Lot
                maxLines: 1,
                keyboardType: TextInputType.text,
                autofocus: false,
                decoration: new InputDecoration(
                  labelText: 'Animal Lot',
                  hintText: 'Enter animal Lot...',
                ),
                validator: (value) =>
                    value.isEmpty ? 'Lot can\'t be empty' : null,
                controller: _lotController,
              ),
              new TextFormField( // Park
                maxLines: 1,
                keyboardType: TextInputType.text,
                autofocus: false,
                decoration: new InputDecoration(
                  labelText: 'Animal Park',
                  hintText: 'Enter animal Park...',
                ),
                validator: (value) =>
                    value.isEmpty ? 'Park can\'t be empty' : null,
                controller: _parkController,
              ),
              new TextFormField( // Pathology
                maxLines: 1,
                keyboardType: TextInputType.text,
                autofocus: false,
                decoration: new InputDecoration(
                  labelText: 'Animal Pathology',
                  hintText: 'Enter animal Pathology...',
                ),
                validator: (value) =>
                    value.isEmpty ? 'Pathology can\'t be empty' : null,
                controller: _pathologyController,
              ),
              showErrorMessage(),
              showPrimaryButton(),
            ],
          ),
        ),
    );
  }

  /// Constrói e retorna o [Widget] com o botão para submissão do formulário
  /// de inserção do novo animal.
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
            child: new Text('Create animal',
                style: new TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            onPressed: validateAndSubmit,
          ),
        ),
    );
  }

  /// Constrói e retorna o [Widget] para mostrar a mensagem de erro.
  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: new Text(
              _errorMessage,
              style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.red,
                  height: 1.0),
            ),
          ),
        ],
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }
}
