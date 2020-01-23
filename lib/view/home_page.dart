import 'package:cow_manager/services/authentication.dart';
import 'package:cow_manager/widgets/new_animal.dart';
import 'package:cow_manager/widgets/search_animal.dart';
import 'package:flutter/material.dart';

/// [Widget] da página inicial da aplicação.
class HomePage extends StatefulWidget {
  /// Cria uma instância do [Widget]. Recebe a classe de autenticação [BaseAuth],
  /// o [userId] e o callback para invocar para efetuar o logout a pedido do
  /// utilizador.
  HomePage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

/// Estado do [Widget] da página inicial da aplicação, de onde é possível
/// aceder a todas as funcionalidades da aplicação.
class _HomePageState extends State<HomePage> {

  /// Efetua o logout do utilizador.
  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  /// Indice da opção selecionada na barra de navegação inferior.
  static int _selectedIndex = 0;
  /// Lista de [Widgets] disponíveis na barra de navegação inderior.
  static List<Widget> _widgetOptions = <Widget>[
    SearchAnimal(),
    NewAnimal(),
  ];

  /// Aualiza o indice do item na barra de navegação inferior.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Cow Manager',
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: <Widget>[
          new FlatButton(
              child: new Text('Logout',
                style: new TextStyle(fontSize: 17.0, color: Colors.white),
              ),
              onPressed: signOut
          )
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            title: Text('New Animal'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
