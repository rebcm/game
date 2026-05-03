import 'package:test/test.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'dart:io';

void main() {
  test('Validate BLoC documentation existence', () async {
    final collection = AnalysisContextCollection(
      includedPaths: [Directory('lib').path],
    );
    final contexts = collection.contexts;

    for (var context in contexts) {
      final files = context.contextRoot.analyzedFiles().where((file) => file.endsWith('.dart'));
      for (var file in files) {
        final unit = await context.currentSession.getResolvedUnit(file) as ResolvedUnitResult;
        for (var declaration in unit.declarations) {
          if (declaration is ClassDeclaration && declaration.extendsClause?.superclass.name.lexeme == 'BLoC') {
            final className = declaration.name.lexeme;
            final docFilePath = 'docs/blocos/$className.md';
            expect(File(docFilePath).existsSync(), true, reason: 'Missing documentation for BLoC class $className');
          }
        }
      }
    }
  });
}
