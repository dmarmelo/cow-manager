import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';

abstract class DomainObject {
  String _key;
  String get key => _key;

  DomainObject();

  @mustCallSuper
  DomainObject.fromSnapshot(DataSnapshot snapshot) :
        _key = snapshot.key;

  Map<String, dynamic> toJson();
}