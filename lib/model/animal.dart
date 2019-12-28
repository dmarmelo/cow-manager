import 'package:cow_manager/model/abstract_document.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class Animal extends AbstractDocument {
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

  static var dateFormatter = DateFormat('yyyy-MM-dd');

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

  Animal.fromMap(String key, Map<String, dynamic> values) :
        electronicId = values["id eletrónica"],
        earring = values["brinco"],
        breed = values["raça"],
        birth = dateFormatter.parse(values["data nascimento"]),
        gender = values["sexo"],
        profile = values["perfil"],
        effective = values["efetivo"],
        lot = values["lote"],
        park = values["parque"],
        reproductionCycles = values["ciclos reprodução"] == "" ? 0 : values["ciclos reprodução"],
        pathology = values["patologia"],
        weight = values["peso atual"] is int ? (values["peso atual"] as int).toDouble(): values["peso atual"],
        userId = values["userId"],
        super.fromMap(key);

  Animal.fromSnapshot(DataSnapshot snapshot) {
      Animal.fromMap(snapshot.key, snapshot.value);
  }

  @override
  toJson() {
    return {
      "id eletrónica": electronicId,
      "brinco": earring,
      "raça": breed,
      "data nascimento": dateFormatter.format(birth),
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
