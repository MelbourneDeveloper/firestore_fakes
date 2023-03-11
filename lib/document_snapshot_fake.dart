import 'package:cloud_firestore/cloud_firestore.dart';

class DocumentSnapshotFake implements DocumentSnapshot<Map<String, dynamic>> {
  DocumentSnapshotFake(this._data);
  final Map<String, dynamic> _data;

  @override
  dynamic operator [](Object field) {
    // TODO: implement []
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? data() => _data;

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
  // TODO: implement reference
  DocumentReference<Map<String, dynamic>> get reference =>
      throw UnimplementedError();
}
