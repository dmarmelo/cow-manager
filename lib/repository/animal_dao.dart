import 'package:cow_manager/model/animal.dart';
import 'package:cow_manager/repository/abstract_dao.dart';

class AnimalDao extends AbstractDao<Animal>{
  AnimalDao() : super("animals");

  @override
  Animal mapToClass(String key, Map<String, dynamic> values) {
    return Animal.fromMap(key, values);
  }

}