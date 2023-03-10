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
    final firestore = setup();

    //Act: call the actual code
    final actualDocumentSnapshot = await addAndFetchUser(
      firestore,
      <String, dynamic>{
        'first': 'Ada',
        'last': 'Lovelace',
        'born': 1815,
      },
    );

    //Assert: Check the results
    final data = actualDocumentSnapshot.data()!;
    expect(data['born'], 1815);
    expect(data['first'], 'Ada');
    expect(data['last'], 'Lovelace');
  });

  test('Test update and then retrieve it', () async {
    const documentId = '123';

    final firestore = FirebaseFirestoreFake.fromSingleDocumentData(
      {'born': 1800},
      documentId,
    );

    await firestore.collection('users').doc(documentId).update({'born': 2023});

    final fetchedDocumentReference =
        firestore.collection('users').doc(documentId);

    //Assert: Check the results
    final data = (await fetchedDocumentReference.get()).data()!;
    expect(data['born'], 2023);
  });

  test('Test set and then retrieve it', () async {
    const documentId = '123';

    final documentSnapshotData = <String, dynamic>{};

    final firestore = FirebaseFirestoreFake(
      (n) => CollectionReferenceFake(
        documentReference: (id) => DocumentReferenceFake(
          documentId,
          setData: (d) async {
            for (final entry in d.entries) {
              documentSnapshotData[entry.key] = entry.value;
            }
          },
          getSnapshot: () async => DocumentSnaphotFake(documentSnapshotData),
        ),
      ),
    );

    await firestore.collection('users').doc(documentId).set({'born': 2023});

    final fetchedDocumentReference =
        firestore.collection('users').doc(documentId);

    //Assert: Check the results
    final fetchedData = (await fetchedDocumentReference.get()).data()!;
    expect(fetchedData['born'], 2023);
    expect(documentSnapshotData['born'], 2023);
  });
}

///Arrange: Configure the fake
FirebaseFirestoreFake setup() {
  //The users collection
  final users = <String, DocumentReferenceFake>{};

  final usersCollectionReference = CollectionReferenceFake(
    addDocumentReference: (data) async {
      //Generate a random documentId
      final documentId = const Uuid().v4();

      //Put the document in the users map by id and return it
      return users.putIfAbsent(
        documentId,
        () => DocumentReferenceFake(
          documentId,
          getSnapshot: () async => DocumentSnaphotFake(data),
        ),
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
