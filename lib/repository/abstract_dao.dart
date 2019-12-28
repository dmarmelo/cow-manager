import 'dart:async';

import 'package:cow_manager/model/abstract_document.dart';
import 'package:firebase_database/firebase_database.dart';

/// Helper abstraction to access Firebase database data.
abstract class AbstractDao<CLAZZ extends AbstractDocument> {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final String path;
  DatabaseReference ref;

  /// Receives the [path] of the collection to access.
  AbstractDao(this.path) {
    ref = _database.reference().child(path);
  }

  /// Maps the object key and all fields from a map to the actual object class.
  CLAZZ mapToClass(String key, Map<String, dynamic> values);

  /// Maps the object fileld from a [DataSnapshot] to the actual object.
  CLAZZ snapshotToClass(DataSnapshot snapshot) {
    return mapToClass(snapshot.key, snapshot.value);
  }

  /// Crates a new object in the collection and returns it.
  Future<CLAZZ> create(CLAZZ obj) {
    var newKey = ref.push().key;
    var future = ref.child(newKey).set(obj.toJson());
    return future.then((value) {
      obj.key = newKey;
      return obj;
    });
  }

  /// Reads an object from the collection by its [key].
  Future<CLAZZ> read(String key) {
    return ref.child(key).once().then((snapshot) => snapshotToClass(snapshot));
  }

  /// Updates an already existing object in the collection.
  Future<void> update(CLAZZ obj) {
    return ref.child(obj.key).set(obj.toJson());
  }

  /// Deletes an object from the collection.
  Future<void> delete(CLAZZ obj) {
    return ref.child(obj.key).remove();
  }

  /// Reads all objects from the collection where the [key] : [value] pair matches.
  Future<List<CLAZZ>> where(String key, dynamic value) {
    var future = ref.orderByChild(key).equalTo(value).once();
    return future.then((result) {
      var list = List<CLAZZ>();
      result.value.forEach((key, value) {
        var valueMap = Map<String, dynamic>.from(value);
        list.add(mapToClass(key, valueMap));
      });
      return list;
    });
  }

  /// Registers an onChiledAdded event on the collection.
  StreamSubscription<Event> onAddListener(onData(Event event)) {
    return ref.onChildAdded.listen(onData);
  }

  /// Registers an onChildChanged event on the collection.
  StreamSubscription<Event> onChangeListener(onData(Event event)) {
    return ref.onChildChanged.listen(onData);
  }

  /// Registers an onChildRemoved event on the collection.
  StreamSubscription<Event> onRemovedListener(onData(Event event)) {
    return ref.onChildRemoved.listen(onData);
  }

}