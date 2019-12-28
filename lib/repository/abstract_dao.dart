import 'dart:async';

import 'package:cow_manager/model/abstract_document.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class AbstractDao<CLAZZ extends AbstractDocument> {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final String path;
  DatabaseReference ref;

  AbstractDao(this.path) {
    ref = _database.reference().child(path);
  }

  Future<String> create(CLAZZ obj) {
    var newKey = ref.push().key;
    var future = ref.child(newKey).set(obj.toJson());
    return future.then((onValue) => newKey);
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

  Future<DataSnapshot> where(String key, dynamic value) {
    return ref.orderByChild(key).equalTo(value).once();
  }

  StreamSubscription<Event> onAddListener(onData(Event event)) {
    return ref.onChildAdded.listen(onData);
  }

  StreamSubscription<Event> onChangeListener(onData(Event event)) {
    return ref.onChildChanged.listen(onData);
  }

  StreamSubscription<Event> onRemovedListener(onData(Event event)) {
    return ref.onChildRemoved.listen(onData);
  }

}