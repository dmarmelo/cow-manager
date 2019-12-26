import 'package:cow_manager/model/abstract_document.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';

abstract class AnimalEvent extends AbstractDocument {
  @mustCallSuper
  AnimalEvent.fromSnapshot(DataSnapshot snapshot) : super.fromSnapshot(snapshot);

  String animalKey;
  DateTime dateTime;

}