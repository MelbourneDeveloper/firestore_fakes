import 'package:cloud_firestore/cloud_firestore.dart';

class QueryFake implements Query<Map<String, dynamic>> {
  QueryFake({this.doGet, this.snapshotsStream});

  final Future<QuerySnapshot<Map<String, dynamic>>> Function()? doGet;
  final Stream<QuerySnapshot<Map<String, dynamic>>>? snapshotsStream;

  @override
  AggregateQuery count() {
    // TODO: implement count
    throw UnimplementedError();
  }

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
  Future<QuerySnapshot<Map<String, dynamic>>> get([GetOptions? options]) =>
      doGet == null
          ? throw UnimplementedError(
              'You must doGet to the constructor of'
              ' QueryFake',
            )
          : doGet!();

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
  Stream<QuerySnapshot<Map<String, dynamic>>> snapshots({
    bool includeMetadataChanges = false,
  }) =>
      snapshotsStream == null
          ? throw UnimplementedError(
              'You must supply snapshots to the constructor of '
              'QueryFake')
          : snapshotsStream!;

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
  }) {
    // TODO: implement where
    throw UnimplementedError();
  }

  @override
  Query<R> withConverter<R>({
    required FromFirestore<R> fromFirestore,
    required ToFirestore<R> toFirestore,
  }) {
    // TODO: implement withConverter
    throw UnimplementedError();
  }
}
