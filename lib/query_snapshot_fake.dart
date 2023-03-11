import 'package:cloud_firestore/cloud_firestore.dart';

class QuerySnapshotFake implements QuerySnapshot<Map<String, dynamic>> {
  QuerySnapshotFake(this._docs);

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> _docs;

  @override
  // TODO: implement docChanges
  List<DocumentChange<Map<String, dynamic>>> get docChanges =>
      throw UnimplementedError();

  @override
  List<QueryDocumentSnapshot<Map<String, dynamic>>> get docs => _docs;

  @override
  // TODO: implement metadata
  SnapshotMetadata get metadata => throw UnimplementedError();

  @override
  int get size => _docs.length;
}
