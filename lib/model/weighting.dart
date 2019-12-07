import 'package:cow_manager/model/animal_event.dart';
import 'package:firebase_database/firebase_database.dart';

class Weighting extends AnimalEvent {
  Weighting.fromSnapshot(DataSnapshot snapshot) : super.fromSnapshot(snapshot);

  double weight;

  @override
  toJson() {
    // TODO: implement toJson
    return null;
  }

}