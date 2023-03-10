import 'package:cloud_firestore/cloud_firestore.dart';

class QuerySnapshotFake implements QuerySnapshot<Map<String, dynamic>> {
  QuerySnapshotFake({required this.getDocs});

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> Function() getDocs;

  @override
  // TODO: implement docChanges
  List<DocumentChange<Map<String, dynamic>>> get docChanges =>
      throw UnimplementedError();

  @override
  List<QueryDocumentSnapshot<Map<String, dynamic>>> get docs => getDocs();

  @override
  // TODO: implement metadata
  SnapshotMetadata get metadata => throw UnimplementedError();

  @override
  // TODO: implement size
  int get size => throw UnimplementedError();
}
