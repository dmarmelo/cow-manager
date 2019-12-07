import 'package:cow_manager/repository/abstract_dao.dart';
import 'package:cow_manager/model/animal.dart';

class AnimalDao extends AbstractDao<Animal>{
  AnimalDao() : super("animals");

}