import 'package:cloud_firestore/cloud_firestore.dart';

typedef Where = Query<Map<String, dynamic>> Function(
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
})?;

class WhereClause {
  WhereClause(
    this.field, {
    this.arrayContains,
    this.arrayContainsAny,
    this.isEqualTo,
    this.isGreaterThan,
    this.isGreaterThanOrEqualTo,
    this.isLessThan,
    this.isLessThanOrEqualTo,
    this.isNotEqualTo,
    this.isNull,
    this.whereIn,
    this.whereNotIn,
  });

  final Object field;
  final Object? arrayContains;
  final Iterable<Object?>? arrayContainsAny;
  final Object? isEqualTo;
  final Object? isGreaterThan;
  final Object? isGreaterThanOrEqualTo;
  final Object? isLessThan;
  final Object? isLessThanOrEqualTo;
  final Object? isNotEqualTo;
  final bool? isNull;
  final Iterable<Object?>? whereIn;
  final Iterable<Object?>? whereNotIn;
}
