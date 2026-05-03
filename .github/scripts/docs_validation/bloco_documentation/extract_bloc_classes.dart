import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';

void main(List<String> args) {
  final collection = AnalysisContextCollection(includedPaths: ['lib/']);
  final contexts = collection.contexts;

  for (final context in contexts) {
    final analysisResult = context.currentSession.getResolvedUnit('lib/main.dart');
    if (analysisResult is ResolvedUnitResult) {
      final unit = analysisResult.unit;
      unit.declarations.forEach((declaration) {
        if (declaration is ClassDeclaration) {
          final classElement = declaration.declaredElement;
          if (classElement != null && classElement.supertype != null && classElement.supertype!.element.name == 'Bloc') {
            print('Class: ${classElement.name}');
            final documentation = classElement.documentationComment;
            if (documentation != null) {
              print('Documentation: $documentation');
            }
          }
        }
      });
    }
  }
}
