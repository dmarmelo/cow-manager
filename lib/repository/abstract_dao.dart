import 'package:cow_manager/model/domain_object.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class AbstractDao<CLAZZ extends DomainObject> {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final String path;
  DatabaseReference ref;

  AbstractDao(this.path) {
    ref = _database.reference().child(path);
  }

  Future<void> create(CLAZZ obj) {
    return ref.push().set(obj.toJson());
  }

  Future<DataSnapshot> read(String key) {
    return ref.child(key).once();
  }

  Future<void> update(CLAZZ obj) {
    return ref.child(obj.key).set(obj.toJson());
  }

  Future<void> delete(CLAZZ obj) {
    return ref.child(obj.key).remove();
  }

}