import 'package:cow_manager/model/abstract_document.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

abstract class AnimalEvent extends AbstractDocument {
  String animalKey;
  DateTime dateTime;

  static var dateTimeFormatter = DateFormat('yyyy-MM-dd HH:mm:ss');

  AnimalEvent(this.animalKey, this.dateTime);

  AnimalEvent.fromMap(String key, Map<String, dynamic> values) :
        animalKey = values["animalKey"],
        dateTime = dateTimeFormatter.parse(values["dateTime"]),
        super.fromMap(key);

  AnimalEvent.fromSnapshot(DataSnapshot snapshot);

  @override
  @mustCallSuper
  Map<String, dynamic> toJson() {
    return {
      "animalKey": animalKey,
      "dateTime": dateTimeFormatter.format(dateTime)
    };
  }

}