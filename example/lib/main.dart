import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_fakes/firestore_fakes.dart';
import 'package:flutter/material.dart';

final FirebaseFirestore firestore = FirebaseFirestoreFake.stateful();

class Book {
  Book(this.isbn, this.title, this.author, this.category);

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        json['isbn'] as String,
        json['title'] as String,
        json['author'] as String,
        json['category'] as String,
      );
  final String isbn;
  final String title;
  final String author;
  final String category;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'ISBN': isbn,
        'title': title,
        'author': author,
        'category': category,
      };
}

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
  Widget build(BuildContext context) => StreamBuilder(
        stream: firestore
            .collection('books')
            .where('category', isEqualTo: 'philosophy')
            .snapshots(),
        builder: (context, snapshot) => Scaffold(
          appBar: AppBar(
            title: const Text('Books'),
          ),
          body: snapshot.connectionState == ConnectionState.done
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
      );
}
