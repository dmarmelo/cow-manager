import 'package:cow_manager/services/authentication.dart';
import 'package:cow_manager/view/root_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

/// Widget raiz da aplicação.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Cow Manager',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: new RootPage(auth: new Auth()),
    );
  }
}
