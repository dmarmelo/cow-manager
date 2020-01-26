import 'package:cow_manager/services/authentication.dart';
import 'package:flutter/material.dart';

/// [Widget] da página de login e signup.
class LoginSignupPage extends StatefulWidget {
  /// Cria uma instância do [Widget]. Recebe a classe de autenticação [BaseAuth]
  /// e o callback para invocar após o login bem sucedido.
  LoginSignupPage({this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;

  @override
  State<StatefulWidget> createState() => new _LoginSignupPageState();
}

/// Estado do [Widget] da página de login e sign up, onde é gerido o processo
/// de login e de sign up.
class _LoginSignupPageState extends State<LoginSignupPage> {
  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _errorMessage;

  bool _isLoginForm;
  bool _isLoading;

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    _isLoginForm = true;
    super.initState();
  }

  /// Valida e guarda o formulário.
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  /// Valida e processa o login ou o signup.
  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (validateAndSave()) {
      String userId = "";
      try {
        if (_isLoginForm) {
          userId = await widget.auth.signIn(_email, _password);
          print('Signed in: $userId');
          if (userId != null && userId.length > 0) {
            widget.loginCallback();
          }
        }
        else {
          userId = await widget.auth.signUp(_email, _password);
          print('Signed up user: $userId');
          toggleFormMode();
        }
        /*if (userId != null && userId.length > 0 && _isLoginForm) {
          widget.loginCallback();
        }*/
      } catch (e) {
        print('Error: $e');
        setState(() {
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  /// Limpa o formulário.
  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  /// Alterna o modo do formulário entre login e sign up.
  void toggleFormMode() {
    resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
            'Cow Manager', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          _showForm(),
          _showCircularProgress(),
        ],
      ),
    );
  }

  /// Constrói e retorna o [Widget] de espera.
  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  /// Constrói e retorna o [Widget] do formulário.
  Widget _showForm() {
    return new Container(
      padding: EdgeInsets.all(16.0),
      child: new Form(
        key: _formKey,
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            showLogo(),
            showEmailInput(),
            showPasswordInput(),
            showErrorMessage(),
            showPrimaryButton(),
            showSecondaryButton(),
          ],
        ),
      ),
    );
  }

  /// Constrói e retorna o [Widget] do logo da aplicação.
  Widget showLogo() {
    return new Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 100.0,
          child: Image.asset('assets/cow-orange.png'),
        ),
      ),
    );
  }

  /// Constrói e retorna o [Widget] de inserção do email.
  Widget showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Email',
          icon: new Icon(
            Icons.mail,
            color: Colors.black,
          ),
        ),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  /// Constrói e retorna o [Widget] de inserção da password.
  Widget showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Password',
          icon: new Icon(
            Icons.lock,
            color: Colors.black,
          ),
        ),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }

  /// Constrói e retorna o [Widget] do botão de login/sign up.
  Widget showPrimaryButton() {
    return new Padding(
      padding: EdgeInsets.fromLTRB(50.0, 25.0, 50.0, 0.0),
      child: SizedBox(
        height: 40.0,
        child: new RaisedButton(
          elevation: 5.0,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
          color: Colors.orange,
          child: new Text(_isLoginForm ? 'Login' : 'Create account',
            style: new TextStyle(fontSize: 20.0, color: Colors.white),
          ),
          onPressed: validateAndSubmit,
        ),
      ),
    );
  }

  /// Constrói e retorna o [Widget] do botão para alterar entre os modos de
  /// login e sign up do formulário.
  Widget showSecondaryButton() {
    return new FlatButton(
        child: new Text(
          _isLoginForm ? 'Create an account' : 'Have an account? Sign in',
          style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
        ),
        onPressed: toggleFormMode
    );
  }

  /// Constrói e retorna o [Widget] para mostrar a mensagem de erro.
  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Center(
          child: new Text(
            _errorMessage,
            style: TextStyle(
                fontSize: 13.0,
                color: Colors.red,
                height: 1.0,
            ),
          ),
        ),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }
}
