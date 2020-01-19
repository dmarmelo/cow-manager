import 'package:cow_manager/model/animal_event.dart';
import 'package:firebase_database/firebase_database.dart';

class Birth extends AnimalEvent {
  int maleNumber;
  int femaleNumber;
  int stillbirths;

  Birth(String animalKey, DateTime dateTime, this.maleNumber, this.femaleNumber, this.stillbirths) : super(animalKey, dateTime);

  Birth.fromMap(String key, Map<String, dynamic> values) :
        maleNumber = values["numero machos"],
        femaleNumber = values["numero femeas"],
        stillbirths = values["nados mortos"],
        super.fromMap(key, values);

  Birth.fromSnapshot(DataSnapshot snapshot) : super.fromSnapshot(snapshot) {
    Birth.fromMap(snapshot.key, snapshot.value);
  }

  @override
  toJson() {
    var superJson = super.toJson();
    Map<String, dynamic> json = {
      "numero machos": maleNumber,
      "numero femeas": femaleNumber,
      "nados mortos": stillbirths
    };
    superJson.addAll(json);
    return superJson;
  }

}