import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_fakes/firestore_fakes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test Streaming Queries', () async {
    final snapshotsStreamController =
        StreamController<QuerySnapshot<Map<String, dynamic>>>();

    final firestore = FirebaseFirestoreFake.stateful(
      whereForCollection: (collectionPath) => (
        field, {
        arrayContains,
        arrayContainsAny,
        isEqualTo,
        isGreaterThan,
        isGreaterThanOrEqualTo,
        isLessThan,
        isLessThanOrEqualTo,
        isNotEqualTo,
        isNull,
        whereIn,
        whereNotIn,
      }) =>
          QueryFake(snapshots: snapshotsStreamController.stream),
    );

    final snapshots = firestore
        .collection('books')
        .where('category', isEqualTo: 'philosophy')
        .snapshots();

    final firstQuerySnapshotFuture = snapshots.first;

    snapshotsStreamController.add(
      QuerySnapshotFake([
        QueryDocumentSnapshotFake({'title': 'Hi'})
      ]),
    );

    final firstQuerySnapshot = await firstQuerySnapshotFuture;
    expect(firstQuerySnapshot.docs.length, 1);
    expect(firstQuerySnapshot.docs[0].data()['title'], 'Hi');

    await snapshotsStreamController.close();
  });
}
