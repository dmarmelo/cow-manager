import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class Animal {
  String key;
  String electronicId;
  String earring;
  String breed;
  DateTime birth;
  String gender;
  String profile;
  String effective;
  String lot;
  String park;
  int reproductionCycles;
  String pathology;
  double weight;
  String userId;

  static var formatter = DateFormat('yyyy-MM-dd');

  Animal(
      this.electronicId,
      this.earring,
      this.breed,
      this.birth,
      this.gender,
      this.profile,
      this.effective,
      this.lot,
      this.park,
      this.reproductionCycles,
      this.pathology,
      this.weight,
      this.userId
      );

  Animal.fromSnapshot(DataSnapshot snapshot) :
        key = snapshot.key,
        electronicId = snapshot.value["id eletrónica"],
        earring = snapshot.value["brinco"],
        breed = snapshot.value["raça"],
        birth = formatter.parse(snapshot.value["data nascimento"]),
        gender = snapshot.value["sexo"],
        profile = snapshot.value["perfil"],
        effective = snapshot.value["efetivo"],
        lot = snapshot.value["lote"],
        park = snapshot.value["parque"],
        reproductionCycles = snapshot.value["ciclos reprodução"] == "" ? 0 : snapshot.value["ciclos reprodução"],
        pathology = snapshot.value["patologia"],
        weight = snapshot.value["peso atual"] is int ? (snapshot.value["peso atual"] as int).toDouble(): snapshot.value["peso atual"],
        userId = snapshot.value["userId"];

  toJson() {
    return {
      "id eletrónica": electronicId,
      "brinco": earring,
      "raça": breed,
      "data nascimento": formatter.format(birth),
      "sexo": gender,
      "perfil": profile,
      "efetivo": effective,
      "lote": lot,
      "parque": park,
      "ciclos reprodução": reproductionCycles,
      "patologia": pathology,
      "peso atual": weight,
      "userId": userId,
    };
  }
}
