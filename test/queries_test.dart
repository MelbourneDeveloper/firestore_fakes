
import 'package:firestore_fakes/firestore_fakes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
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
