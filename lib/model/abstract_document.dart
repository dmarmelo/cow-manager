import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';

/// Abstraction that has to be implemented by all classes
/// that are being mapped to Firebase database documents.
abstract class AbstractDocument {
  String key;

  /// Zero args constructor.
  AbstractDocument();

  /// Creates an instance given it's key.
  @mustCallSuper
  AbstractDocument.fromMap(String key) :
        key = key;

  /// Creates an instance given a [DataSnapshot] from Firebase database.
  AbstractDocument.fromSnapshot(DataSnapshot snapshot);

  /// Converts the instance to a Json Object.
  Map<String, dynamic> toJson();

  /// Converts the instance to a Json Object containing the key.
  Map<String, dynamic> toJsonWKey() {
    Map<String, dynamic> json = {
      "key": key
    };
    json.addAll(toJson());
    return json;
  }

}