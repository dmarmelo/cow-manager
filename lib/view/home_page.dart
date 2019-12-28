import 'dart:async';

import 'package:cow_manager/model/animal.dart';
import 'package:cow_manager/services/authentication.dart';
import 'package:cow_manager/view/new_animal.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

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
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  final _textEditingController = TextEditingController();

  List<Animal> _animalList;
  Query _animalQuery;
  StreamSubscription<Event> _onAnimalAddedSubscription;
  StreamSubscription<Event> _onAnimalChangedSubscription;

  @override
  void initState() {
    super.initState();

    _animalList = new List();
    _animalQuery = _database.reference().child("animais");
    _onAnimalAddedSubscription = _animalQuery.onChildAdded.listen(onEntryAdded);
    _onAnimalChangedSubscription =
        _animalQuery.onChildChanged.listen(onEntryChanged);
  }

  @override
  void dispose() {
    _onAnimalAddedSubscription.cancel();
    _onAnimalChangedSubscription.cancel();
    super.dispose();
  }

  onEntryChanged(Event event) {
    var oldEntry = _animalList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      _animalList[_animalList.indexOf(oldEntry)] =
          Animal.fromSnapshot(event.snapshot);
    });
  }

  onEntryAdded(Event event) {
    setState(() {
      _animalList.add(Animal.fromSnapshot(event.snapshot));
    });
  }

  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  showAddAnimalDialog(BuildContext context) async {
    _textEditingController.clear();
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new Row(
              children: <Widget>[
                new Expanded(
                    child: new TextField(
                  controller: _textEditingController,
                  autofocus: true,
                  decoration: new InputDecoration(
                    labelText: 'Add new todo',
                  ),
                ))
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new FlatButton(
                  child: const Text('Save'),
                  onPressed: () {
                    //addNewAnimal(_textEditingController.text.toString());
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }
/*
  Widget showAnimalList() {
    if (_animalList.length > 0) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: _animalList.length,
          itemBuilder: (BuildContext context, int index) {
            String animalId = _animalList[index].key;
            String electronicId = _animalList[index].electronicId;
            String earring = _animalList[index].earring;
            String userId = _animalList[index].userId;
            return Dismissible(
              key: Key(animalId),
              background: Container(color: Colors.red),
              onDismissed: (direction) async {
                //deleteTodo(animalId, index);
              },
              child: ListTile(
                title: Text(
                  earring,
                  style: TextStyle(fontSize: 20.0),
                ),
                trailing: Text(
                  electronicId,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            );
          });
    } else {
      return Center(
          child: Text(
        "Welcome. Your list is empty",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 30.0),
      ));
    }
  }

 */
  Widget inserirAnimal(){
    return new FlatButton(
            onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (ctx) => NewAnimalPage()));
          }
          );
  }

  Widget buscarAnimal(){
    return new FlatButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (ctx) => NewAnimalPage()));
        }
    );
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
      children: ListTile.divideTiles(
          context: context,
          tiles: [
            ListTile(
              title: Text('Inserir'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => inserirAnimal(),
            ),
            ListTile(
              title: Text('Buscar animal'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => buscarAnimal(),
            ),
          ]
      ).toList(),
    );
  }
}
