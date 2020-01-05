import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _EventPageState();
}

class _EventPageState extends State<EventPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Events',style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: _showMenu(),
    );
  }

  Widget _showMenu() {
    return new ListView(
      children: ListTile.divideTiles(context: context, tiles: [
        ListTile(
            title: Text('Birth'),
            trailing: Icon(Icons.add),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    //builder: (context) => NewAnimalPage(userId: widget.userId),
                  ));
            }),
        ListTile(
            title: Text('Milking'),
            trailing: Icon(Icons.add),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                   // builder: (context) => SearchAnimalPage(),
                  ));
            }),
        ListTile(
            title: Text('Weighting'),
            trailing: Icon(Icons.add),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    //builder: (context) => SearchAnimalPage(),
                  ));
            }),

    ]).toList(),
    );
  }

}
