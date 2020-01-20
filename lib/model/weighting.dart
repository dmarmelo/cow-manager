import 'package:cow_manager/model/animal_event.dart';
import 'package:firebase_database/firebase_database.dart';

class Weighting extends AnimalEvent {
  double weight;

  Weighting(String animalKey, DateTime dateTime, this.weight) : super(animalKey, dateTime);

  Weighting.fromMap(String key, Map<String, dynamic> values) :
        weight = values["peso"] is int ? (values["peso"] as int).toDouble(): values["peso"],
        super.fromMap(key, values);

  Weighting.fromSnapshot(DataSnapshot snapshot) : super.fromSnapshot(snapshot) {
    Weighting.fromMap(snapshot.key, snapshot.value);
  }

  @override
  toJson() {
    var superJson = super.toJson();
    Map<String, dynamic> json = {
      "peso": weight,
    };
    superJson.addAll(json);
    return superJson;
  }
}


