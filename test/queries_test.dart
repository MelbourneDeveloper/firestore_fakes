import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_fakes/firestore_fakes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test Streaming Queries - Manual', () async {
    final snapshotsStreamController =
        StreamController<QuerySnapshot<Map<String, dynamic>>>();

    final firestore = FirebaseFirestoreFake.stateful(
      whereForCollection: (collectionPath, controller) =>
          collectionPath == 'books'
              ? (
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
                  field == 'category'
                      ? QueryFake(
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
                        )
                      : throw ArgumentError('Wrong field here')
              : throw ArgumentError('Wrong collection path here'),
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
        QueryDocumentSnapshotFake({
          'title': 'Hi',
          'category': 'philosophy',
        })
      ]),
    );

    final firstQuerySnapshot = await firstQuerySnapshotFuture;
    expect(firstQuerySnapshot.docs.length, 1);
    expect(firstQuerySnapshot.docs[0].data()['title'], 'Hi');

    await snapshotsStreamController.close();
  });

  test('Test Streaming Queries - Via Event Bubbling', () async {
    final snapshotsStreamController =
        StreamController<QuerySnapshot<Map<String, dynamic>>>();

    final firestore = FirebaseFirestoreFake.stateful(
      onCollectionChanged: (path, documents, queries) => path == 'books'
          ? snapshotsStreamController.add(
              QuerySnapshotFake([
                QueryDocumentSnapshotFake({
                  'title': 'Hi',
                  'category': 'philosophy',
                })
              ]),
            )
          : throw UnimplementedError('Wrong collection'),
      whereForCollection: (collectionPath, controller) =>
          collectionPath == 'books'
              ? (
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
                  )
              : throw ArgumentError('Wrong collection path here'),
    );

    final query = firestore
        .collection('books')
        .where('category', isEqualTo: 'philosophy') as QueryFake;

    expect(query.whereClause!.field, 'category');
    expect(query.whereClause!.isEqualTo, 'philosophy');

    final snapshots = query.snapshots();

    final firstQuerySnapshotFuture = snapshots.first;

    await firestore.collection('books').add({
      'title': 'Hi',
      'category': 'philosophy',
    });

    final firstQuerySnapshot = await firstQuerySnapshotFuture;
    expect(firstQuerySnapshot.docs.length, 1);
    expect(firstQuerySnapshot.docs[0].data()['title'], 'Hi');

    await snapshotsStreamController.close();
  });

  test('Test Streaming Queries - More Automatic', () async {
    final firestore = FirebaseFirestoreFake.stateful(
      onCollectionChanged: (path, documents, queries) {
        for (final query in queries) {
          if (path != 'books') {
            throw UnimplementedError('Wrong collection');
          }
          query.controller.add(
            QuerySnapshotFake([
              QueryDocumentSnapshotFake({
                'title': 'Hi',
                'category': 'philosophy',
              })
            ]),
          );
        }
      },
      whereForCollection: (collectionPath, controller) =>
          collectionPath == 'books'
              ? (
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
                    snapshots: controller.stream,
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
                  )
              : throw ArgumentError('Wrong collection path here'),
    );

    final query = firestore
        .collection('books')
        .where('category', isEqualTo: 'philosophy') as QueryFake;

    expect(query.whereClause!.field, 'category');
    expect(query.whereClause!.isEqualTo, 'philosophy');

    final snapshots = query.snapshots();

    final firstQuerySnapshotFuture = snapshots.first;

    await firestore.collection('books').add({
      'title': 'Hi',
      'category': 'philosophy',
    });

    final firstQuerySnapshot = await firstQuerySnapshotFuture;
    expect(firstQuerySnapshot.docs.length, 1);
    expect(firstQuerySnapshot.docs[0].data()['title'], 'Hi');

    //TODO: Ensure streams are closed
  });
}
