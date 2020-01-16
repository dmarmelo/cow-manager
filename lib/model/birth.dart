import 'package:cow_manager/model/abstract_document.dart';
import 'package:firebase_database/firebase_database.dart';

class Birth extends AbstractDocument {
  String fatherKey;
  String motherKey;
  int pupsNumber;
  int stillbirths;

  Birth(this.fatherKey, this.motherKey, this.pupsNumber, this.stillbirths);

  Birth.fromMap(String key, Map<String, dynamic> values) :
        fatherKey = values["id pai"],
        motherKey = values["id mae"],
        pupsNumber = values["numero crias"],
        stillbirths = values["nados mortos"],
        super.fromMap(key);

  Birth.fromSnapshot(DataSnapshot snapshot) {
    Birth.fromMap(snapshot.key, snapshot.value);
  }

  @override
  toJson() {
    return {
      "id pai": fatherKey,
      "id mae": motherKey,
      "numero crias": pupsNumber,
      "nados mortos": stillbirths
    };
  }

}