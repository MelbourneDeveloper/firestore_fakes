import 'package:cloud_firestore/cloud_firestore.dart';

class QueryDocumentSnapshotFake
    implements QueryDocumentSnapshot<Map<String, dynamic>> {
  QueryDocumentSnapshotFake(this._data, [this._reference]);

  final Map<String, dynamic> _data;
  final DocumentReference<Map<String, dynamic>>? _reference;

  @override
  dynamic operator [](Object field) {
    // TODO: implement []
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> data() => _data;

  @override
  // TODO: implement exists
  bool get exists => throw UnimplementedError();

  @override
  dynamic get(Object field) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  // TODO: implement id
  String get id => throw UnimplementedError();

  @override
  // TODO: implement metadata
  SnapshotMetadata get metadata => throw UnimplementedError();

  @override
  DocumentReference<Map<String, dynamic>> get reference =>
      _reference ??
      (throw UnimplementedError(
          'You must supply _reference to the constructor of '
          'QueryDocumentSnapshotFake'));
}
