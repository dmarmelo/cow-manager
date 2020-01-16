import 'package:cow_manager/model/animal_event.dart';
import 'package:firebase_database/firebase_database.dart';

class Milking extends AnimalEvent {
  double amount;

  Milking(String animalKey, DateTime dateTime, this.amount) : super(animalKey, dateTime);

  Milking.fromMap(String key, Map<String, dynamic> values) :
        amount = values["quantidade"],
        super.fromMap(key, values);

  Milking.fromSnapshot(DataSnapshot snapshot) : super.fromSnapshot(snapshot) {
    Milking.fromMap(snapshot.key, snapshot.value);
  }

  @override
  toJson() {
    var superJson = super.toJson();
    Map<String, dynamic> json = {
      "quantidade": amount,
    };
    superJson.addAll(json);
    return superJson;
  }

}