import 'package:flutter_test/flutter_test.dart';
import 'package:passdriver/features/metadata_persistence/metadata_persistence_provider.dart';

void main() {
  test('metadata persistence flow', () async {
    final metadataPersistenceProvider = MetadataPersistenceProvider();
    final metadata = {'key': 'value'};
    await metadataPersistenceProvider.persistMetadata(metadata);
    final persistedMetadata = await metadataPersistenceProvider.getMetadata();
    expect(persistedMetadata, metadata);
  });
}
