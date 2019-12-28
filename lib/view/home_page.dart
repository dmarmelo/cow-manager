import 'package:cow_manager/services/authentication.dart';
import 'package:cow_manager/view/new_animal.dart';
import 'package:cow_manager/view/search_animal.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.logoutCallback}) : super(key: key);

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
                child: new Text(
                    'Logout',
                    style: new TextStyle(fontSize: 17.0, color: Colors.white)
                ),
                onPressed: signOut
            )
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
              title: Text('New Animal'),
              trailing: Icon(Icons.add),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => NewAnimalPage(),
                  )
                );
              }
            ),
            ListTile(
              title: Text('Search Animal'),
              trailing: Icon(Icons.search),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchAnimalPage(),
                    )
                  );
                }
            ),
          ]
      ).toList(),
    );
  }

}
