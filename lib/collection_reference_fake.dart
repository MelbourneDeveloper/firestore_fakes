// ignore_for_file: subtype_of_sealed_class

import 'package:cloud_firestore/cloud_firestore.dart';

class CollectionReferenceFake
    implements CollectionReference<Map<String, dynamic>> {
  CollectionReferenceFake(
    this._path, {
    this.addFake,
    this.docFake,
    this.whereFake,
  });

  final Future<DocumentReference<Map<String, dynamic>>> Function(
    Map<String, dynamic> data,
  )? addFake;

  final DocumentReference<Map<String, dynamic>> Function(String? path)? docFake;

  final Query<Map<String, dynamic>> Function(
    Object field, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    Iterable<Object?>? arrayContainsAny,
    Iterable<Object?>? whereIn,
    Iterable<Object?>? whereNotIn,
    bool? isNull,
  })? whereFake;

  final String _path;

  @override
  Future<DocumentReference<Map<String, dynamic>>> add(
    Map<String, dynamic> data,
  ) =>
      addFake == null
          ? throw UnimplementedError(
              'You must supply addFake to the constructor of'
              ' CollectionReferenceFake',
            )
          : addFake!(data);

  @override
  AggregateQuery count() {
    // TODO: implement count
    throw UnimplementedError();
  }

  @override
  DocumentReference<Map<String, dynamic>> doc([String? path]) => docFake == null
      ? throw UnimplementedError(
          'You must supply docFake to the constructor of '
          'CollectionReferenceFake',
        )
      : docFake!(path);

  @override
  Query<Map<String, dynamic>> endAt(Iterable<Object?> values) {
    // TODO: implement endAt
    throw UnimplementedError();
  }

  @override
  Query<Map<String, dynamic>> endAtDocument(
    DocumentSnapshot<Object?> documentSnapshot,
  ) {
    // TODO: implement endAtDocument
    throw UnimplementedError();
  }

  @override
  Query<Map<String, dynamic>> endBefore(Iterable<Object?> values) {
    // TODO: implement endBefore
    throw UnimplementedError();
  }

  @override
  Query<Map<String, dynamic>> endBeforeDocument(
    DocumentSnapshot<Object?> documentSnapshot,
  ) {
    // TODO: implement endBeforeDocument
    throw UnimplementedError();
  }

  @override
  // TODO: implement firestore
  FirebaseFirestore get firestore => throw UnimplementedError();

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> get([GetOptions? options]) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  // TODO: implement id
  String get id => throw UnimplementedError();

  @override
  Query<Map<String, dynamic>> limit(int limit) {
    // TODO: implement limit
    throw UnimplementedError();
  }

  @override
  Query<Map<String, dynamic>> limitToLast(int limit) {
    // TODO: implement limitToLast
    throw UnimplementedError();
  }

  @override
  Query<Map<String, dynamic>> orderBy(Object field, {bool descending = false}) {
    // TODO: implement orderBy
    throw UnimplementedError();
  }

  @override
  // TODO: implement parameters
  Map<String, dynamic> get parameters => throw UnimplementedError();

  @override
  // TODO: implement parent
  DocumentReference<Map<String, dynamic>>? get parent =>
      throw UnimplementedError();

  @override
  // TODO: implement path
  String get path => _path;

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> snapshots({
    bool includeMetadataChanges = false,
  }) {
    // TODO: implement snapshots
    throw UnimplementedError();
  }

  @override
  Query<Map<String, dynamic>> startAfter(Iterable<Object?> values) {
    // TODO: implement startAfter
    throw UnimplementedError();
  }

  @override
  Query<Map<String, dynamic>> startAfterDocument(
    DocumentSnapshot<Object?> documentSnapshot,
  ) {
    // TODO: implement startAfterDocument
    throw UnimplementedError();
  }

  @override
  Query<Map<String, dynamic>> startAt(Iterable<Object?> values) {
    // TODO: implement startAt
    throw UnimplementedError();
  }

  @override
  Query<Map<String, dynamic>> startAtDocument(
    DocumentSnapshot<Object?> documentSnapshot,
  ) {
    // TODO: implement startAtDocument
    throw UnimplementedError();
  }

  @override
  Query<Map<String, dynamic>> where(
    Object field, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    Iterable<Object?>? arrayContainsAny,
    Iterable<Object?>? whereIn,
    Iterable<Object?>? whereNotIn,
    bool? isNull,
  }) =>
      whereFake == null
          ? throw UnimplementedError(
              'You must supply whereFake to the constructor of'
              ' CollectionReferenceFake',
            )
          : whereFake!(
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
            );

  @override
  @override
  CollectionReference<R> withConverter<R extends Object?>({
    required FromFirestore<R> fromFirestore,
    required ToFirestore<R> toFirestore,
  }) {
    // TODO: implement withConverter
    throw UnimplementedError();
  }
}
