// ignore_for_file: subtype_of_sealed_class

import 'package:cloud_firestore/cloud_firestore.dart';

class DocumentReferenceFake implements DocumentReference<Map<String, dynamic>> {
  DocumentReferenceFake(
    this._id, {
    this.getFake,
    this.updateData,
    this.setFake,
    this.snapshotsFake,
  });

  final Future<DocumentSnapshot<Map<String, dynamic>>> Function()? getFake;
  final Future<void> Function(Map<Object, Object?>)? updateData;
  final Future<void> Function(Map<String, dynamic> data)? setFake;
  final String _id;
  final Stream<DocumentSnapshot<Map<String, dynamic>>>? snapshotsFake;

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
      getFake == null
          ? throw UnimplementedError(
              'You must supply getFake to the constructor of '
              'DocumentReferenceFake')
          : getFake!();

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
      setFake == null
          ? throw UnimplementedError(
              'You must supply setFake to the constructor of '
              'DocumentReferenceFake')
          : setFake!(data);

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> snapshots({
    bool includeMetadataChanges = false,
  }) =>
      snapshotsFake == null
          ? throw UnimplementedError(
              'You must supply snapshotsFake to the constructor of '
              'DocumentReferenceFake')
          : snapshotsFake!;

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
