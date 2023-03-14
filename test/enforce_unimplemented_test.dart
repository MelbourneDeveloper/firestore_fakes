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

    test('Test onChanged gives the correct documents', () async {
      late Map<String, DocumentReferenceFake> docs;
      final fake = CollectionReferenceFake.stateful(
        'books',
        onChanged: (documents) => docs = documents,
      );
      await fake.add({'name': 'bob'});
      final actual = (await docs.values.first.get()).data()!;
      expect(docs.length, 1);
      expect(actual['name'], 'bob');
    });
  });
}
