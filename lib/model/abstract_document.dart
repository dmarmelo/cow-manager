import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';

abstract class AbstractDocument {
  String key;

  AbstractDocument();

  @mustCallSuper
  AbstractDocument.fromMap(String key) :
        key = key;

  AbstractDocument.fromSnapshot(DataSnapshot snapshot);

  Map<String, dynamic> toJson();

  Map<String, dynamic> toJsonWKey() {
    Map<String, dynamic> json = {
      "key": key
    };
    json.addAll(toJson());
    return json;
  }

}