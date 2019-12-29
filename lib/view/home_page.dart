import 'package:cow_manager/model/animal.dart';
import 'package:cow_manager/services/authentication.dart';
import 'package:cow_manager/view/animal_profile.dart';
import 'package:cow_manager/view/new_animal.dart';
import 'package:cow_manager/view/search_animal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Cow Manager'),
        actions: <Widget>[
          new FlatButton(
              child: new Text('Logout',
                  style: new TextStyle(fontSize: 17.0, color: Colors.white)),
              onPressed: signOut)
        ],
      ),
      body: _showMenu(),
    );
  }

  Widget _showMenu() {
    return new ListView(
      children: ListTile.divideTiles(context: context, tiles: [
        ListTile(
            title: Text('New Animal'),
            trailing: Icon(Icons.add),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewAnimalPage(userId: widget.userId),
                  ));
            }),
        ListTile(
            title: Text('Search Animal'),
            trailing: Icon(Icons.search),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchAnimalPage(),
                  ));
            }),
        // TODO REMOVE ONLY FOR TESTS
        ListTile(
            title: Text('Animal Profile'),
            trailing: Icon(Icons.search),
            onTap: () {
              var newAnimal = new Animal(
                  "1234567890",
                  "EAR246851",
                  "exbreed",
                  DateFormat("yyyy-mm-dd").parse("2019-21-29"),
                  "Male",
                  "exprofile",
                  "exefective",
                  "exlot",
                  "expark",
                  2,
                  "expathology",
                  60,
                  widget.userId);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnimalProfilePage(animal: newAnimal),
                  ));
            }),
      ]).toList(),
    );
  }
}
