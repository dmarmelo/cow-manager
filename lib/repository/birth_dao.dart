import 'package:cow_manager/model/birth.dart';
import 'package:cow_manager/repository/abstract_dao.dart';

class BirthDao extends AbstractDao<Birth>{
  BirthDao() : super("births");

  @override
  Birth mapToClass(String key, Map<String, dynamic> values) {
    return Birth.fromMap(key, values);
  }

}