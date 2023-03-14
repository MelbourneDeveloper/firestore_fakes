import 'package:firestore_fakes/firestore_fakes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test Streaming Queries', () async {
    final firestore = FirebaseFirestoreFake.stateful();

    final query = firestore
        .collection('books')
        .where('category', isEqualTo: 'philosophy') as QueryFake;

    expect(query.whereClause!.field, 'category');
    expect(query.whereClause!.isEqualTo, 'philosophy');

    final snapshots = query.snapshots();

    //Awaits the first snapshot which will have no data
    final firstSnappy = await snapshots.first;
    expect(firstSnappy.docs.length, 0);

    final secondSnapshotFuture = snapshots.first;
    await firestore.collection('books').add({
      'title': 'Hi',
      'category': 'philosophy',
    });

    //Await the new book to be inserted
    final secondQuerySnapshot = await secondSnapshotFuture;

    expect(secondQuerySnapshot.docs.length, 1);
    expect(secondQuerySnapshot.docs[0].data()['title'], 'Hi');

    //TODO: Ensure streams are closed
  });

  test('Test Streaming Queries - Specify onCollectionChanged', () async {
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
