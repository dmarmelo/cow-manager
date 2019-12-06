import 'package:flutter/material.dart';
import 'package:cow_manager/services/authentication.dart';
import 'package:cow_manager/pages/root_page.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Cow Manager',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: new RootPage(auth: new Auth()));
  }
}
