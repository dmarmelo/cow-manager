import 'package:cow_manager/model/animal_event.dart';
import 'package:firebase_database/firebase_database.dart';

class Birth extends AnimalEvent {
  Birth.fromSnapshot(DataSnapshot snapshot) : super.fromSnapshot(snapshot);

  String fatherKey;
  String motherKey;

  @override
  toJson() {
    // TODO: implement toJson

    return null;
  }

}