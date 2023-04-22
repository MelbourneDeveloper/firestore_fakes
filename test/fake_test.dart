import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_fakes/firestore_fakes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

void main() {
  test('Test adding user and then retrieving it - Stateful', () async {
    //Arrange: Create the fake Firestore and let it manager the state internally
    final firestore = FirebaseFirestoreFake.stateful();

    //Act: call the actual code
    //Add user to users collection
    final documentReference =
        await firestore.collection('users').add(<String, dynamic>{
      'first': 'Ada',
      'last': 'Lovelace',
      'born': 1815,
    });

    //Get document by Id
    final fetchedDocumentReference =
        firestore.collection('users').doc(documentReference.id);

    //Return the document
    final actualDocumentSnapshot = await fetchedDocumentReference.get();

    //Assert: Check the results
    final data = actualDocumentSnapshot.data()!;
    expect(data['born'], 1815);
    expect(data['first'], 'Ada');
    expect(data['last'], 'Lovelace');
  });

  test('Test adding user and then retrieving it - Stateless', () async {
    //Arrange: Configure the fake Firestore

    //Note: We maintain the state external to the fakes

    //These are the user documents
    final users = <String, DocumentReferenceFake>{};

    //This is the users collection
    final usersCollectionReference = CollectionReferenceFake(
      'users',
      add: (data) async {
        //Generate a random documentId
        final documentId = const Uuid().v4();

        //Put the document in the users map by id and return it
        return users.putIfAbsent(
          documentId,
          () => DocumentReferenceFake(
            documentId,
            get: () async => DocumentSnapshotFake(documentId, data),
          ),
        );
      },
      doc: (path) => users[path]!,
    );

    //Declare the map of collections
    final collections = {
      usersCollectionReference.path: usersCollectionReference,
    };

    //Create the fake firestore and give it access to the collections
    final firestore =
        FirebaseFirestoreFake(collection: (name) => collections[name]!);

    //Act: call the actual code
    //Add user to users collection
    final documentReference =
        await firestore.collection('users').add(<String, dynamic>{
      'first': 'Ada',
      'last': 'Lovelace',
      'born': 1815,
    });

    //Get document by Id
    final fetchedDocumentReference =
        firestore.collection('users').doc(documentReference.id);

    //Return the document
    final actualDocumentSnapshot = await fetchedDocumentReference.get();

    //Assert: Check the results
    final data = actualDocumentSnapshot.data()!;
    expect(data['born'], 1815);
    expect(data['first'], 'Ada');
    expect(data['last'], 'Lovelace');
  });

  test('Test update and then retrieve it - Stateful', () async {
    //Arrange: create a collection with an existing user
    final collectionReferenceFake = CollectionReferenceFake.stateful('users');

    final documentReference = await collectionReferenceFake.add({'born': 1800});

    final firestore = FirebaseFirestoreFake.stateful(
      collections: {collectionReferenceFake.path: collectionReferenceFake},
    );

    //Act: this is the actual code to test
    await firestore
        .collection('users')
        .doc(documentReference.id)
        .update({'born': 2023});

    final fetchedDocumentReference =
        firestore.collection('users').doc(documentReference.id);

    //Assert: Check the results
    final data = (await fetchedDocumentReference.get()).data()!;
    expect(data['born'], 2023);
  });

  test('Test update and then retrieve it - Stateless', () async {
    //Arrange
    const documentId = '123';

    final documentSnapshotData = <String, dynamic>{'born': 1800};

    final documentSnaphotFake =
        DocumentSnapshotFake(documentId, documentSnapshotData);
    final documentReferenceFake = DocumentReferenceFake(
      documentId,
      get: () async => documentSnaphotFake,
      update: (data) async {
        for (final entry in data.entries) {
          documentSnapshotData[entry.key as String] = entry.value;
        }
      },
    );

    final firestore = FirebaseFirestoreFake(
      collection: (name) => CollectionReferenceFake(
        'users',
        doc: (path) => documentReferenceFake,
      ),
    );

    //Act: This is the actual code to test
    await firestore.collection('users').doc(documentId).update({'born': 2023});

    final fetchedDocumentReference =
        firestore.collection('users').doc(documentId);

    //Assert: Check the results
    final data = (await fetchedDocumentReference.get()).data()!;
    expect(data['born'], 2023);
  });

  test('Test update and then retrieve it with state', () async {
    //Arrange: create a collection with an existing user
    const documentId = '123';

    final documentReferenceFake =
        DocumentReferenceFake.stateful(documentId, {'born': 1800}, () {});

    final firestore = FirebaseFirestoreFake(
      collection: (name) => CollectionReferenceFake(
        'users',
        doc: (path) => documentReferenceFake,
      ),
    );

    //Act: this is the actual code
    await firestore.collection('users').doc(documentId).update({'born': 2023});

    final fetchedDocumentReference =
        firestore.collection('users').doc(documentId);

    //Assert: Check the results
    final data = (await fetchedDocumentReference.get()).data()!;
    expect(data['born'], 2023);
  });

  test('Test set and then retrieve it - Stateless', () async {
    const documentId = '123';

    final documentSnapshotData = <String, dynamic>{};

    final firestore = FirebaseFirestoreFake(
      collection: (n) => CollectionReferenceFake(
        'users',
        doc: (id) => DocumentReferenceFake(
          documentId,
          set: (d) async {
            for (final entry in d.entries) {
              documentSnapshotData[entry.key] = entry.value;
            }
          },
          get: () async =>
              DocumentSnapshotFake(documentId, documentSnapshotData),
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
    expect(firestore.collection('users').path, 'users');
  });

  ///Test that we can query a collection with where, and then listen for
  ///streamed results
  test('Test Query Snapshot Streams', () async {
    final queriesStreamController =
        StreamController<QuerySnapshot<Map<String, dynamic>>>.broadcast();

    final firestore = FirebaseFirestoreFake(
      collection: (n) => CollectionReferenceFake(
        'users',
        where: (
          field, {
          isEqualTo,
          isNotEqualTo,
          isLessThan,
          isLessThanOrEqualTo,
          isGreaterThan,
          isGreaterThanOrEqualTo,
          arrayContains,
          arrayContainsAny,
          whereIn,
          whereNotIn,
          isNull,
        }) =>
            field != 'born' || isEqualTo != 2023
                ? throw UnimplementedError('Wrong field here')
                : QueryFake(
                    snapshots: queriesStreamController.stream,
                  ),
      ),
    );

    final firstQuerySnapshot = firestore
        .collection('users')
        .where('born', isEqualTo: 2023)
        .snapshots()
        .first;

    queriesStreamController.add(
      QuerySnapshotFake([
        QueryDocumentSnapshotFake({'born': 2023})
      ]),
    );

    final fetchedData = (await firstQuerySnapshot).docs.first.data();

    expect(fetchedData['born'], 2023);

    await queriesStreamController.close();
  });

  ///Tests that we can listen to a document snapshot stream
  test('Test Document Snapshot Stream', () async {
    const documentId = '123';

    final documentsStreamController =
        StreamController<DocumentSnapshot<Map<String, dynamic>>>.broadcast();

    final firestore = FirebaseFirestoreFake(
      collection: (n) => CollectionReferenceFake(
        'users',
        doc: (id) => DocumentReferenceFake(
          documentId,
          snapshots: documentsStreamController.stream,
        ),
      ),
    );

    final fetchedDocumentReference =
        firestore.collection('users').doc().snapshots().first;

    documentsStreamController
        .add(DocumentSnapshotFake(documentId, {'name': 'jim'}));

    final documentSnapshot = await fetchedDocumentReference;

    expect(documentSnapshot.id, documentId);

    final fetchedData = documentSnapshot.data()!;

    expect(fetchedData['name'], 'jim');

    await documentsStreamController.close();
  });
}
