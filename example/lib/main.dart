import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_fakes/firestore_fakes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyHomePage(firestore: FirebaseFirestoreFake.stateful()));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.firestore, super.key});

  final FirebaseFirestore firestore;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: StreamBuilder(
          stream: widget.firestore
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
                          (documentSnapshot) => ListTile(
                            title: Text(documentSnapshot['title'] as String),
                          ),
                        )
                        .toList(),
                  )
                : const CircularProgressIndicator.adaptive(),
            floatingActionButton: FloatingActionButton(
              onPressed: () async =>
                  widget.firestore.collection('books').add(<String, dynamic>{
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
