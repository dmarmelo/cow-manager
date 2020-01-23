import 'package:cow_manager/services/authentication.dart';
import 'package:cow_manager/view/home_page.dart';
import 'package:cow_manager/view/login_signup_page.dart';
import 'package:flutter/material.dart';

/// Enumerado que representa os possivéis estados da autenticação.
enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

/// [Widget] da página raiz da aplicação.
class RootPage extends StatefulWidget {
  RootPage({this.auth});

  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

/// Estado da página raiz da aplicação, onde é gerido a autenticação.
/// Consoante o estado da autenticação é mostrado o [Widget] de autenticação
/// ou o [Widget] da páginal inicial da aplicação após autenticação.
class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";

  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.uid;
        }
        authStatus = user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }

  /// Método para ser invocado do [Widget] de autenticação para atualizar
  /// o estado da autenticação.
  void loginCallback() {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _userId = user.uid.toString();
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  /// Método para ser invocado do [Widget] da página inicial para atualizar
  /// o estado da autenticação.
  void logoutCallback() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }

  /// Constrói e retorna o [Widget] para o ecrã de espera.
  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return new LoginSignupPage(
          auth: widget.auth,
          loginCallback: loginCallback,
        );
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId != null && _userId.length > 0) {
          return new HomePage(
            userId: _userId,
            auth: widget.auth,
            logoutCallback: logoutCallback,
          );
        }
        else
          return buildWaitingScreen();
        break;
      default:
        return buildWaitingScreen();
    }
  }
}
