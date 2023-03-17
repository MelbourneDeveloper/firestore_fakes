# firestore_fakes

This library gives you a set of fakes that allow you fake Firebase Firestore. It is similar to [fake_cloud_firestore](https://pub.dev/packages/fake_cloud_firestore) in that you can fake Firestore. However, this library gives you more control. You can add code to capture the events where documents are added to a collection, and you can capture the events where there is a fetch request. You can return whatever you want, or let the fakes automatically manage the state for you. 

## Stateful vs. Stateless

You configure the classes with function composition by passing values into their constructors. You can manage the state (or use no state) external to the classes, or you can allow the classes to automatically manage the state internally. When the fakes manage the state internally, they aim to mimic the functionality of Firestore. It is possible to write an entire app that stores data in memory and behaves like the real Firestore database.

This is a stateful example that mimics streaming. You can use this as your Flutter state management solution. Check out the example tab for a Flutter example that updates the state using `StreamBuilder`.

```dart
//This mimics Firestore
final firestore = FirebaseFirestoreFake.stateful();

//Grab the stream of book document snapshots
final snapshots = firestore
    .collection('books')
    .where('category', isEqualTo: 'philosophy')
    .snapshots();

//Awaits the first snapshot which will have no data
await snapshots.first;

final secondSnapshotFuture = snapshots.first;

//Add a book document
await firestore.collection('books').add({
  'title': 'The Republic',
  'category': 'philosophy',
});

//Await the new book to be inserted
final secondQuerySnapshot = await secondSnapshotFuture;

print(secondQuerySnapshot.docs[0].data()['title']);
```

Here is a stateless example. This requires more configuration but gives you absolute control.

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

Please understand that this is only an alpha release and only the bare minimum was implemented. Feel free to add PRs to implement more functionality.

