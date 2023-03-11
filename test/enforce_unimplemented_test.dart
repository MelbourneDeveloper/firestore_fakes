import 'package:firestore_fakes/firestore_fakes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CollectionReferenceFake', () {
    test('throws UnimplementedError when addDocumentReference is not supplied',
        () {
      final collectionReference = CollectionReferenceFake('path');

      expect(
        () async => collectionReference.add({}),
        throwsA(isA<UnimplementedError>()),
      );
    });

    test('throws UnimplementedError when documentReference is not supplied',
        () {
      final collectionReference = CollectionReferenceFake('path');

      expect(collectionReference.doc, throwsA(isA<UnimplementedError>()));
    });

    test('throws UnimplementedError when getWhere is not supplied', () {
      final collectionReference = CollectionReferenceFake('path');

      expect(
        () => collectionReference.where('field', isEqualTo: 'value'),
        throwsA(isA<UnimplementedError>()),
      );
    });
  });
}
