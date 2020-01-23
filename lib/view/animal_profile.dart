import 'package:cow_manager/model/animal.dart';
import 'package:cow_manager/view/birth_page.dart';
import 'package:cow_manager/view/milking_page.dart';
import 'package:cow_manager/view/weighting_page.dart';
import 'package:cow_manager/widgets/profile_more_options_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// [Widget] do perfil de um animal.
class AnimalProfilePage extends StatefulWidget {
  /// Cria uma instância do [Widget]. Recebe o [Animal] a mostra o perfil.
  AnimalProfilePage({Key key, this.animal}) : super(key: key);

  final Animal animal;

  @override
  State<StatefulWidget> createState() => new _AnimalProfilePageState();
}

/// Estado do [Widget] do perfil de um animal, onde é possível vizualizar as
/// informações do animal e ainda efetuar ações sobre este.
class _AnimalProfilePageState extends State<AnimalProfilePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Animal Profile'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: InkWell(
              child: GestureDetector(
                onTap: () => bottomSheet(context),
                child: Icon(
                  Icons.more_vert,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: _showProfile(),
      ),
    );
  }

  /// Constrói e retorna o [Widget] com a lista de propriedades que constituem
  /// o objeto [Animal].
  Widget _showProfile() {
    return new ListView(
      children: ListTile.divideTiles(context: context, tiles: [
        ListTile(
          title: Text("Eletronic Id"),
          trailing: Text(widget.animal.electronicId),
        ),
        ListTile(
          title: Text('Earring'),
          trailing: Text(widget.animal.earring),
        ),
        ListTile(
          title: Text('Birth'),
          trailing: Text(widget.animal.birth.toString().substring(0, 10)),
        ),
        ListTile(
          title: Text('Gender'),
          trailing: Text(widget.animal.gender),
        ),
        ListTile(
          title: Text('Profile'),
          trailing: Text(widget.animal.profile),
        ),
        ListTile(
          title: Text('Effective'),
          trailing: Text(widget.animal.effective),
        ),
        ListTile(
          title: Text('Lot'),
          trailing: Text(widget.animal.lot),
        ),
        ListTile(
          title: Text('Park'),
          trailing: Text(widget.animal.park),
        ),
        ListTile(
          title: Text('Reproduction Cycles'),
          trailing: Text(widget.animal.reproductionCycles.toString()),
        ),
        ListTile(
          title: Text('Pathology'),
          trailing: Text(widget.animal.pathology),
        ),
        ListTile(
          title: Text('Last Weighting'),
          trailing: Text(widget.animal.lastWeight.toString() + "Kg"),
        ),
        ListTile(
          title: Text('Last Milking'),
          trailing: Text(widget.animal.lastMilking.toString() + "ml"),
        ),
      ]).toList(),
    );
  }

  /// Abre o menu de mais opções para efetuar ações sobre o animal.
  void bottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        return ProfileMoreOptionsSheet(
          callBackOptionTapped: moreOptionsSheetCallback,
        );
      },
    );
  }

  /// Callback que é executado pelo menu do mais opções [ProfileMoreOptionsSheet]
  /// para abrir a respetiva página da ações escolhida no menu.
  void moreOptionsSheetCallback(ProfileMoreOptions option) {
    switch (option) {
      case ProfileMoreOptions.WEIGHTING: {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WeightingPage(animal: widget.animal)));
        break;
      }
      case ProfileMoreOptions.MILKING: {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MilkingPage(animal: widget.animal)));
        break;
      }
      case ProfileMoreOptions.BIRTH: {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BirthPage(animal: widget.animal)));
        break;
      }
    }
  }
}
