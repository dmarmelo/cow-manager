import 'package:cow_manager/model/animal.dart';
import 'package:cow_manager/widgets/more_options_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnimalProfilePage extends StatefulWidget {
  AnimalProfilePage({Key key, this.animal}) : super(key: key);

  final Animal animal;

  @override
  State<StatefulWidget> createState() => new _AnimalProfilePageState();
}

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
        child: this._showProfile(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_invitation),
            title: Text('Birth'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Business'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('School'),
          ),
        ],
      ),
    );
  }

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
          title: Text('Weight'),
          trailing: Text(widget.animal.weight.toString() + "Kg"),
        ),
      ]).toList(),
    );
  }

  void bottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
          return MoreOptionsSheet(
            callBackColorTapped: null,
            callBackOptionTapped: null,
          );
        });
  }
}
