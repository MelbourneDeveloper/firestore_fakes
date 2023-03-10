# firebase_fakes

This library gives you a set of fakes that allow you fake Firebase Firestore. It is similar to [fake_cloud_firestore](https://pub.dev/packages/fake_cloud_firestore) in that you can fake Firestore. However, this library gives you more control. You can add code to capture the events where documents are added to a collection, and you can capture the events where there is a fetch request. You can return whatever you want. Here is a typical example.

```dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_fakes/collection_reference_fake.dart';
import 'package:firestore_fakes/document_reference_fake.dart';
import 'package:firestore_fakes/document_snapshot_fake.dart';
import 'package:firestore_fakes/firebase_firestore_fake.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

void main() {
  test('Test adding a user to the users collection and then retrieving it',
      () async {
    //Arrange: Configure the fake Firestore
    FirebaseFirestore firestore = setup();

    //Act: call the actual code
    final actualDocumentSnapshot = await addAndFetchUser(
      firestore,
      <String, dynamic>{
        "first": "Ada",
        "last": "Lovelace",
        "born": 1815,
      },
    );

    //Assert: Check the results
    expect(actualDocumentSnapshot.data()!['born'], 1815);
    expect(actualDocumentSnapshot.data()!['first'], 'Ada');
    expect(actualDocumentSnapshot.data()!['last'], "Lovelace");
  });
}

///Arrange: Configure the fake
FirebaseFirestoreFake setup() {
  //The users collection
  final users = <String, DocumentReferenceFake>{};

  var usersCollectionReference = CollectionReferenceFake(
    addDocumentReference: (data) async {
      //Generate a random documentId
      final documentId = const Uuid().v4();

      //Put the document in the users map by id and return it
      return users.putIfAbsent(
        documentId,
        () => DocumentReferenceFake(
            () async => DocumentSnaphotFake(data), documentId),
      );
    },
    documentReference: (path) => users[path]!,
  );

  //Declare the map of collections
  final collections = {'users': usersCollectionReference};

  //Return the fake firestore
  return FirebaseFirestoreFake((name) => collections[name]!);
}

///Act: This is the real code that you might find in your app
Future<DocumentSnapshot<Map<String, dynamic>>> addAndFetchUser(
  FirebaseFirestore firestore,
  Map<String, dynamic> user,
) async {
  //Add user to users collection
  final documentReference = await firestore.collection('users').add(user);

  //Get document by Id
  final fetchedDocumentReference =
      firestore.collection('users').doc(documentReference.id);

  //Return the document
  return fetchedDocumentReference.get();
}
```