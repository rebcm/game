import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'dart:io';

void main() {
  final currentDirectory = Directory.current.path;
  final collection = AnalysisContextCollection(includedPaths: ['$currentDirectory/lib']);
  final contexts = collection.contexts;

  for (final context in contexts) {
    final files = context.contextRoot.analyzedFiles();
    for (final file in files) {
      if (file.endsWith('.dart')) {
        final result = context.currentSession.getParsedUnit(file);
        if (result is ParsedUnitResult) {
          final unit = result.unit;
          unit.declarations.forEach((declaration) {
            if (declaration is ClassDeclaration) {
              final classElement = declaration.declaredElement;
              if (classElement != null && _isBloc(classElement)) {
                final className = classElement.name;
                final documentation = classElement.documentationComment?.tokens.map((token) => token.toString()).join('\n');
                print('Class: $className');
                if (documentation != null) {
                  print('Documentation: $documentation');
                }
              }
            }
          });
        }
      }
    }
  }
}

bool _isBloc(ClassElement element) {
  return element.allSupertypes.any((supertype) => supertype.element.name == 'Bloc');
}
