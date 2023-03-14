import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_fakes/firestore_fakes.dart';
import 'package:flutter/material.dart';

final FirebaseFirestore firestore = FirebaseFirestoreFake.stateful(
  onCollectionChanged: (path, collectionDocuments, queries) async {
    for (final queryFakeAndController in queries) {
      final futures = collectionDocuments.values.map((ref) => ref.get());
      final documentSnapshots = (await Future.wait(futures))
          .where(
            (snapshot) {
              final whereClause = queryFakeAndController.queryFake.whereClause;
              if (whereClause == null) {
                return true;
              }
              if (whereClause.isEqualTo != null) {
                return snapshot.data()![whereClause.field] ==
                    whereClause.isEqualTo;
              } else {
                throw UnimplementedError('Where clauses of this type '
                    'have not been implemented. Please log a GitHub issue and '
                    ' hopefully contribute with a PR');
              }
            },
          )
          .map((snapshot) => QueryDocumentSnapshotFake(snapshot.data()!))
          .toList();
      queryFakeAndController.controller.add(
        QuerySnapshotFake(documentSnapshots),
      );
    }
  },
);

void main() {
  runApp(const MyHomePage());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: StreamBuilder(
          stream: firestore
              .collection('books')
              .where('category', isEqualTo: 'philosophy')
              .snapshots(),
          builder: (context, snapshot) => Scaffold(
            appBar: AppBar(
              title: const Text('Books'),
            ),
            body: snapshot.data != null
                ? ListView(
                    children: snapshot.data!.docs
                        .map(
                          (e) => ListTile(
                            title: Text(e['title'] as String),
                          ),
                        )
                        .toList(),
                  )
                : const CircularProgressIndicator.adaptive(),
            floatingActionButton: FloatingActionButton(
              onPressed: () async =>
                  firestore.collection('books').add(<String, dynamic>{
                'title': 'The Art of War',
                'category': 'philosophy',
              }),
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          ),
        ),
      );
}
