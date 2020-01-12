import 'package:cow_manager/model/animal_event.dart';
import 'package:firebase_database/firebase_database.dart';

class Weighting extends AnimalEvent {
  Weighting.fWeightingromSnapshot(DataSnapshot snapshot) : super.fromSnapshot(snapshot);

  double weight;

  @override
  toJson() {
    return {
      "peso atual": weight,
    };
  }
}


