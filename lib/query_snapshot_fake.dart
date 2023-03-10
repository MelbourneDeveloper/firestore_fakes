import 'package:cloud_firestore/cloud_firestore.dart';

class QuerySnapshotFake implements QuerySnapshot<Map<String, dynamic>> {
  @override
  // TODO: implement docChanges
  List<DocumentChange<Map<String, dynamic>>> get docChanges =>
      throw UnimplementedError();

  @override
  // TODO: implement docs
  List<QueryDocumentSnapshot<Map<String, dynamic>>> get docs =>
      throw UnimplementedError();

  @override
  // TODO: implement metadata
  SnapshotMetadata get metadata => throw UnimplementedError();

  @override
  // TODO: implement size
  int get size => throw UnimplementedError();
}
