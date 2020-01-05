import 'package:cow_manager/model/animal_event.dart';
import 'package:firebase_database/firebase_database.dart';

class Milking extends AnimalEvent {
  Milking.fromSnapshot(DataSnapshot snapshot) : super.fromSnapshot(snapshot);

  double amount;

  @override
  toJson() {
    return {
      "amount": amount,
    };
  }

}