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
          QueryFake(
            snapshots: snapshotsStreamController.stream,
            whereClause: WhereClause(
              field,
              arrayContains: arrayContains,
              arrayContainsAny: arrayContainsAny,
              isEqualTo: isEqualTo,
              isGreaterThan: isGreaterThan,
              isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
              isLessThan: isLessThan,
              isLessThanOrEqualTo: isLessThanOrEqualTo,
              isNotEqualTo: isNotEqualTo,
              isNull: isNull,
              whereIn: whereIn,
              whereNotIn: whereNotIn,
            ),
          ),
    );

    final query = firestore
        .collection('books')
        .where('category', isEqualTo: 'philosophy') as QueryFake;

    expect(query.whereClause!.field, 'category');
    expect(query.whereClause!.isEqualTo, 'philosophy');

    final snapshots = query.snapshots();

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
