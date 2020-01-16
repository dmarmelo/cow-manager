import 'package:cow_manager/model/milking.dart';
import 'package:cow_manager/repository/abstract_dao.dart';

class MilkingDao extends AbstractDao<Milking>{
  MilkingDao() : super("milkings");

  @override
  Milking mapToClass(String key, Map<String, dynamic> values) {
    return Milking.fromMap(key, values);
  }

}