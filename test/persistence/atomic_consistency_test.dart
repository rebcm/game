import 'package:flutter_test/flutter_test.dart';
import 'package:rebcm/mundo/gerador.dart';
import 'package:rebcm/blocos/tipo_bloco.dart';
import 'package:rebcm/persistence/database.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Atomic Consistency Tests', () {
    late Database db;

    setUp(() async {
      db = await Database.initTestDatabase();
    });

    tearDown(() async {
      await db.close();
    });

    test('should rollback on failure after insertion', () async {
      final chunk = GeradorMundo.gerarChunk(0, 0);
      await db.insertChunk(chunk);

      // Simulate failure after insertion
      try {
        await db.insertBlock(TipoBloco.GRAMA, 0, 0, 0);
        throw Exception('Simulated failure');
      } catch (e) {
        // Verify rollback
        expect(await db.getBlock(0, 0, 0), isNull);
      }
    });

    test('should not leave orphan records', () async {
      final chunk = GeradorMundo.gerarChunk(0, 0);
      await db.insertChunk(chunk);

      try {
        await db.insertBlock(TipoBloco.GRAMA, 0, 0, 0);
        throw Exception('Simulated failure');
      } catch (e) {
        // Verify no orphan records
        expect(await db.getChunk(0, 0), isNotNull);
        expect(await db.getBlock(0, 0, 0), isNull);
      }
    });
  });
}
