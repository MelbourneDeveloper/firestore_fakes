// ignore_for_file:  always_put_required_named_parameters_first, strict_raw_type

import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_fakes/firestore_fakes.dart';
import 'package:firestore_fakes/query_fake_and_stream_controller.dart';

///An empty shell of a [FirebaseFirestore] that can be used for testing or 
///creating an app that does not require a real connection to Firestore
///
///The Stateful version of this class maintains its own state and aims to mimic 
///Firestore, while the Stateless version allows you to compose the 
///functionality and store the state outside of the class. 
///
///You can use this as a mock or a fake. If you want to use this as a mock,
///avoid the Stateful constructors, and return the expected values by 
///passing them through the constructor
class FirebaseFirestoreFake implements FirebaseFirestore {
  FirebaseFirestoreFake({
    CollectionReference<Map<String, dynamic>> Function(String name)? collection,
  }) : _collection = collection;

  ///Creates a stateful FirebaseFirestore fake that maintains its own state and
  ///aims to mimic firebase as closely as possible
  factory FirebaseFirestoreFake.stateful({
    Map<String, CollectionReferenceFake>? collections,
    void Function(
      String path,
      Map<String, DocumentReferenceFake> collectionDocuments,
      List<QueryFakeAndStreamController> queries,
    )?
        onCollectionChanged,
  }) {
    collections ??= <String, CollectionReferenceFake>{};

    onCollectionChanged ??= (path, collectionDocuments, queries) async {
      for (final queryFakeAndController in queries) {
        final futures = collectionDocuments.values.map((ref) => ref.get());
        final documentSnapshots = (await Future.wait(futures))
            .where(
              (snapshot) {
                final whereClause =
                    queryFakeAndController.queryFake.whereClause;
                if (whereClause == null) {
                  return true;
                }
                if (whereClause.isEqualTo != null) {
                  return snapshot.data()![whereClause.field] ==
                      whereClause.isEqualTo;
                } else {
                  throw UnimplementedError('Where clauses of this type '
                      'have not been implemented. Please log a GitHub '
                      'issue and  hopefully contribute with a PR');
                }
              },
            )
            .map((snapshot) => QueryDocumentSnapshotFake(snapshot.data()!))
            .toList();
        queryFakeAndController.controller.add(
          QuerySnapshotFake(documentSnapshots),
        );
      }
    };

    return FirebaseFirestoreFake(
      collection: (collectionPath) {
        //TODO: what is the standard behaviour in firestore?
        //will it add the collection automatically?

        final queriesByCollection =
            <String, List<QueryFakeAndStreamController>>{};

        collections!.putIfAbsent(
          collectionPath,
          () => CollectionReferenceFake.stateful(
            collectionPath,
            onChanged: (documents) {
              onCollectionChanged?.call(
                collectionPath,
                documents,
                queriesByCollection[collectionPath] ?? [],
              );
            },
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
            }) {
              // ignore: close_sinks
              final controller = StreamController<
                  QuerySnapshot<Map<String, dynamic>>>.broadcast();

              final queryFake = QueryFake(
                snapshots: controller.stream,
                whereClause: WhereClause(
                  field,
                  isEqualTo: isEqualTo,
                  isNotEqualTo: isNotEqualTo,
                  isLessThan: isLessThan,
                  isLessThanOrEqualTo: isLessThanOrEqualTo,
                  isGreaterThan: isGreaterThan,
                  isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
                  arrayContains: arrayContains,
                  arrayContainsAny: arrayContainsAny,
                  whereIn: whereIn,
                  whereNotIn: whereNotIn,
                  isNull: isNull,
                ),
              );

              if (queriesByCollection[collectionPath] == null) {
                queriesByCollection[collectionPath] = [];
              }
              queriesByCollection[collectionPath]!.add(
                QueryFakeAndStreamController(
                  queryFake,
                  controller,
                ),
              );

              return queryFake;
            },
          ),
        );

        return collections[collectionPath]!;
      },
    );
  }

  final CollectionReference<Map<String, dynamic>> Function(String name)?
      _collection;

  @override
  FirebaseApp app = FirebaseAppFake();

  @override
  Settings settings = SettingsFake();

  @override
  WriteBatch batch() {
    // TODO: implement batch
    throw UnimplementedError();
  }

  @override
  Future<void> clearPersistence() {
    // TODO: implement clearPersistence
    throw UnimplementedError();
  }

  @override
  CollectionReference<Map<String, dynamic>> collection(String collectionPath) =>
      _collection == null
          ? throw UnimplementedError(
              'You must pass collection to the constructor of'
              ' FirebaseFirestoreFake',
            )
          : _collection!(collectionPath);

  @override
  Query<Map<String, dynamic>> collectionGroup(String collectionPath) {
    // TODO: implement collectionGroup
    throw UnimplementedError();
  }

  @override
  Future<void> disableNetwork() {
    // TODO: implement disableNetwork
    throw UnimplementedError();
  }

  @override
  DocumentReference<Map<String, dynamic>> doc(String documentPath) {
    // TODO: implement doc
    throw UnimplementedError();
  }

  @override
  Future<void> enableNetwork() {
    // TODO: implement enableNetwork
    throw UnimplementedError();
  }

  @override
  Future<void> enablePersistence([PersistenceSettings? persistenceSettings]) {
    // TODO: implement enablePersistence
    throw UnimplementedError();
  }

  @override
  LoadBundleTask loadBundle(Uint8List bundle) {
    // TODO: implement loadBundle
    throw UnimplementedError();
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> namedQueryGet(
    String name, {
    GetOptions options = const GetOptions(),
  }) {
    // TODO: implement namedQueryGet
    throw UnimplementedError();
  }

  @override
  // TODO: implement pluginConstants
  Map get pluginConstants => throw UnimplementedError();

  @override
  Stream<void> snapshotsInSync() {
    // TODO: implement snapshotsInSync
    throw UnimplementedError();
  }

  @override
  Future<void> terminate() {
    // TODO: implement terminate
    throw UnimplementedError();
  }

  @override
  void useFirestoreEmulator(String host, int port, {bool sslEnabled = false}) {
    // TODO: implement useFirestoreEmulator
  }

  @override
  Future<void> waitForPendingWrites() {
    // TODO: implement waitForPendingWrites
    throw UnimplementedError();
  }

  @override
  Future<QuerySnapshot<T>> namedQueryWithConverterGet<T>(
    String name, {
    GetOptions options = const GetOptions(),
    required FromFirestore<T> fromFirestore,
    required ToFirestore<T> toFirestore,
  }) {
    // TODO: implement namedQueryWithConverterGet
    throw UnimplementedError();
  }

  @override
  Future<void> setIndexConfiguration({
    required List<Index> indexes,
    List<FieldOverrides>? fieldOverrides,
  }) {
    // TODO: implement setIndexConfiguration
    throw UnimplementedError();
  }

  @override
  Future<void> setIndexConfigurationFromJSON(String json) {
    // TODO: implement setIndexConfigurationFromJSON
    throw UnimplementedError();
  }

  @override
  Future<T> runTransaction<T>(
    TransactionHandler<T> transactionHandler, {
    Duration timeout = const Duration(seconds: 30),
    int maxAttempts = 5,
  }) {
    // TODO: implement runTransaction
    throw UnimplementedError();
  }
}
