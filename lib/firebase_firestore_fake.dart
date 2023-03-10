// TODO: Put public facing types in this file.

// ignore_for_file: depend_on_referenced_packages

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_fakes/firebase_app_fake.dart';
import 'package:firestore_fakes/settings_fake.dart';

/// Checks if you are awesome. Spoiler: you are.
class FirebaseFirestoreFake implements FirebaseFirestore {
  FirebaseFirestoreFake(this._collection);

  final CollectionReference<Map<String, dynamic>> Function(String name)
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
      _collection(collectionPath);

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
  Future<QuerySnapshot<Map<String, dynamic>>> namedQueryGet(String name,
      {GetOptions options = const GetOptions()}) {
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
  Future<QuerySnapshot<T>> namedQueryWithConverterGet<T>(String name,
      {GetOptions options = const GetOptions(),
      required FromFirestore<T> fromFirestore,
      required ToFirestore<T> toFirestore}) {
    // TODO: implement namedQueryWithConverterGet
    throw UnimplementedError();
  }

  @override
  Future<void> setIndexConfiguration(
      {required List<Index> indexes, List<FieldOverrides>? fieldOverrides}) {
    // TODO: implement setIndexConfiguration
    throw UnimplementedError();
  }

  @override
  Future<void> setIndexConfigurationFromJSON(String json) {
    // TODO: implement setIndexConfigurationFromJSON
    throw UnimplementedError();
  }

  @override
  Future<T> runTransaction<T>(TransactionHandler<T> transactionHandler,
      {Duration timeout = const Duration(seconds: 30), int maxAttempts = 5}) {
    // TODO: implement runTransaction
    throw UnimplementedError();
  }
}
