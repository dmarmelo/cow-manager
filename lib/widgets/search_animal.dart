import 'package:cow_manager/chip_field/ChipFormField.dart';
import 'package:cow_manager/repository/animal_dao.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../view/animal_profile.dart';

/// [Widget] para pesquisa de animais.
class SearchAnimal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SearchAnimalState();
}

/// Estado do [Widget] de pesquisa de animais, onde é realizada a query à base
/// de dados do Firebase e o redirecionamento para o perfil do animal,
/// caso este exista na base de dados.
class _SearchAnimalState extends State<SearchAnimal> {
  ChipFormField _chipFormField;

  @override
  void initState() {
    super.initState();

    _chipFormField = ChipFormField(context, 'HC-06', (chip) {
      print('CHIP: ' + chip);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showChipSearch();
  }

  /// Constrói e retorna o [Widget] com o formulário para pesquisa de um animal.
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
                  style: new TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                onPressed: () => _search(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Procura o identificador do animal inderido na base de dados do Firebase e
  /// em caso da pesquisa retornar resultados é aberto o perfil do animal obtido
  /// da pesquisa. Caso contrário é mostrada uma mensagem a informar que não
  /// existe um animal com aquele id.
  void _search() {
    var chip = _chipFormField.chip;

    AnimalDao().where("id eletrónica", chip).then((results) {
      if (results.length > 0) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AnimalProfilePage(animal: results[0])));
      }
      else {
        Fluttertoast.showToast(
            msg: "Animal Not Found", gravity: ToastGravity.CENTER);
      }
    });
  }
}
