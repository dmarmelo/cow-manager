import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';

abstract class AbstractDocument {
  String _key;
  String get key => _key;

  AbstractDocument();

  @mustCallSuper
  AbstractDocument.fromSnapshot(DataSnapshot snapshot) :
        _key = snapshot.key;

  Map<String, dynamic> toJson();
}