// ignore_for_file: subtype_of_sealed_class

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firestore_fakes/firestore_fakes.dart';

class DocumentReferenceFake implements DocumentReference<Map<String, dynamic>> {
  DocumentReferenceFake(
    this._id, {
    Future<DocumentSnapshot<Map<String, dynamic>>> Function()? get,
    Future<void> Function(Map<Object, Object?>)? update,
    Future<void> Function(Map<String, dynamic>)? set,
    Stream<DocumentSnapshot<Map<String, dynamic>>>? snapshots,
  })  : _set = set,
        _snapshots = snapshots,
        _update = update,
        _get = get;

  factory DocumentReferenceFake.stateful(
    String id,
    Map<String, dynamic> documentSnapshotData,
    void Function() onChanged,
  ) =>
      DocumentReferenceFake(
        id,
        get: () async => DocumentSnapshotFake(id, documentSnapshotData),
        update: (data) async {
          for (final entry in data.entries) {
            documentSnapshotData[entry.key as String] = entry.value;
          }
          onChanged();
        },
        set: (data) async {
          for (final entry in data.entries) {
            documentSnapshotData[entry.key] = entry.value;
          }
          onChanged();
        },
      );

  final Future<DocumentSnapshot<Map<String, dynamic>>> Function()? _get;
  final Future<void> Function(Map<Object, Object?>)? _update;
  final Future<void> Function(Map<String, dynamic> data)? _set;
  final String _id;
  final Stream<DocumentSnapshot<Map<String, dynamic>>>? _snapshots;

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
      _get == null
          ? throw UnimplementedError(
              'You must supply get to the constructor of '
              'DocumentReferenceFake')
          : _get!();

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
  Future<void> set(Map<String, dynamic> data, [SetOptions? options]) => _set ==
          null
      ? throw UnimplementedError('You must supply set to the constructor of '
          'DocumentReferenceFake')
      : _set!(data);

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> snapshots({
    bool includeMetadataChanges = false,
  }) =>
      _snapshots == null
          ? throw UnimplementedError(
              'You must supply snapshots to the constructor of '
              'DocumentReferenceFake')
          : _snapshots!;

  @override
  Future<void> update(Map<Object, Object?> data) => _update == null
      ? throw UnimplementedError('You must supply update to the constructor of '
          'DocumentReferenceFake')
      : _update!(data);

  @override
  DocumentReference<R> withConverter<R>({
    required FromFirestore<R> fromFirestore,
    required ToFirestore<R> toFirestore,
  }) =>
      throw UnimplementedError();
}
