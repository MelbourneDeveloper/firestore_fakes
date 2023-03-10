// ignore_for_file: subtype_of_sealed_class

import 'package:cloud_firestore/cloud_firestore.dart';

class DocumentReferenceFake implements DocumentReference<Map<String, dynamic>> {
  DocumentReferenceFake(
    this._id, {
    required this.getSnapshot,
    this.updateData,
    this.setData,
  });

  final Future<DocumentSnapshot<Map<String, dynamic>>> Function() getSnapshot;
  final Future<void> Function(Map<Object, Object?>)? updateData;
  final Future<void> Function(Map<String, dynamic> data)? setData;
  final String _id;

  @override
  CollectionReference<Map<String, dynamic>> collection(String collectionPath) {
    // TODO: implement collection
    throw UnimplementedError();
  }

  @override
  Future<void> delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  // TODO: implement firestore
  FirebaseFirestore get firestore => throw UnimplementedError();

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> get([GetOptions? options]) =>
      getSnapshot();

  @override
  // TODO: implement id
  String get id => _id;

  @override
  // TODO: implement parent
  CollectionReference<Map<String, dynamic>> get parent =>
      throw UnimplementedError();

  @override
  // TODO: implement path
  String get path => throw UnimplementedError();

  @override
  Future<void> set(Map<String, dynamic> data, [SetOptions? options]) =>
      setData == null
          ? throw UnimplementedError(
              'You must supply setData to the constructor of '
              'DocumentReferenceFake')
          : setData!(data);

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> snapshots({
    bool includeMetadataChanges = false,
  }) {
    // TODO: implement snapshots
    throw UnimplementedError();
  }

  @override
  Future<void> update(Map<Object, Object?> data) =>
      updateData == null ? throw UnimplementedError() : updateData!(data);

  @override
  DocumentReference<R> withConverter<R>({
    required FromFirestore<R> fromFirestore,
    required ToFirestore<R> toFirestore,
  }) =>
      throw UnimplementedError();
}
