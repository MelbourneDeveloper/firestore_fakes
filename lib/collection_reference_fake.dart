// ignore_for_file: subtype_of_sealed_class

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firestore_fakes/firestore_fakes.dart';
import 'package:uuid/uuid.dart';

class CollectionReferenceFake
    implements CollectionReference<Map<String, dynamic>> {
  CollectionReferenceFake(
    this._path, {
    Future<DocumentReference<Map<String, dynamic>>> Function(
      Map<String, dynamic>,
    )?
        add,
    DocumentReference<Map<String, dynamic>> Function(String?)? doc,
    Where where,
    FirebaseFirestore? firestore,
  })  : _where = where,
        _doc = doc,
        _add = add,
        _firestore = firestore ?? FirebaseFirestoreFake();

  factory CollectionReferenceFake.stateful(
    String path, {
    Where where,
  }) {
    final documents = <String, DocumentReferenceFake>{};
    return CollectionReferenceFake(
      path,
      add: (data) async {
        final documentId = const Uuid().v4();
        final documentReference =
            DocumentReferenceFake.stateful(documentId, data);
        return documents[documentId] = documentReference;
      },
      doc: (id) => documents[id]!,
      where: where,
    );
  }

  final Future<DocumentReference<Map<String, dynamic>>> Function(
    Map<String, dynamic> data,
  )? _add;

  final DocumentReference<Map<String, dynamic>> Function(String? path)? _doc;

  final Where _where;

  final String _path;

  final FirebaseFirestore _firestore;

  @override
  Future<DocumentReference<Map<String, dynamic>>> add(
    Map<String, dynamic> data,
  ) =>
      _add == null
          ? throw UnimplementedError(
              'You must supply add to the constructor of'
              ' CollectionReferenceFake',
            )
          : _add!(data);

  @override
  AggregateQuery count() {
    // TODO: implement count
    throw UnimplementedError();
  }

  @override
  DocumentReference<Map<String, dynamic>> doc([String? path]) => _doc == null
      ? throw UnimplementedError(
          'You must supply doc to the constructor of '
          'CollectionReferenceFake',
        )
      : _doc!(path);

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
  FirebaseFirestore get firestore => _firestore;

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
      _where == null
          ? throw UnimplementedError(
              'You must supply where to the constructor of'
              ' CollectionReferenceFake',
            )
          : _where!(
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
