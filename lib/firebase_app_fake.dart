import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


class FirebaseAppFake implements FirebaseApp {
  @override
  Future<void> delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  // TODO: implement isAutomaticDataCollectionEnabled
  bool get isAutomaticDataCollectionEnabled => throw UnimplementedError();

  @override
  // TODO: implement name
  String get name => throw UnimplementedError();

  @override
  // TODO: implement options
  FirebaseOptions get options => throw UnimplementedError();

  @override
  Future<void> setAutomaticDataCollectionEnabled(bool enabled) {
    // TODO: implement setAutomaticDataCollectionEnabled
    throw UnimplementedError();
  }

  @override
  Future<void> setAutomaticResourceManagementEnabled(bool enabled) {
    // TODO: implement setAutomaticResourceManagementEnabled
    throw UnimplementedError();
  }
}
