import 'package:cow_manager/model/weighting.dart';
import 'package:cow_manager/repository/abstract_dao.dart';

class WeightingDao extends AbstractDao<Weighting>{
  WeightingDao() : super("weightings");

  @override
  Weighting mapToClass(String key, Map<String, dynamic> values) {
    return Weighting.fromMap(key, values);
  }

}