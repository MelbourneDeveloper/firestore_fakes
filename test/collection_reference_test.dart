import 'package:firestore_fakes/firestore_fakes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Tests for CollectionReferenceFake', () {
    test('Test where', () async {
      final expectedData = <String, dynamic>{
        'name': 'John',
        'age': 30,
      };

      final collectionRef = CollectionReferenceFake(
        'my-collection',
        where: (
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
            field != 'name'
                ? throw ArgumentError('Wrong field here')
                : QueryFake(
                    get: () async => QuerySnapshotFake(
                      [QueryDocumentSnapshotFake(expectedData)],
                    ),
                  ),
      );
      final query = collectionRef.where('name', isEqualTo: 'John');

      final querySnapshot = await query.get();

      final firstQueryDocumentSnapshot = querySnapshot.docs.first;

      final actualData = firstQueryDocumentSnapshot.data();

      expect(actualData['name'], expectedData['name']);
      expect(actualData['age'], expectedData['age']);
    });
  });
}
