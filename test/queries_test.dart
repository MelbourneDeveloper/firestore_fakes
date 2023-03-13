import 'package:firestore_fakes/firestore_fakes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test Streaming Queries', () async {
    final firestore = FirebaseFirestoreFake.stateful(
      whereForCollection: (collectionPath) => (
        field, {
        arrayContains,
        arrayContainsAny,
        isEqualTo,
        isGreaterThan,
        isGreaterThanOrEqualTo,
        isLessThan,
        isLessThanOrEqualTo,
        isNotEqualTo,
        isNull,
        whereIn,
        whereNotIn,
      }) =>
          QueryFake(),
    );
  });
}
