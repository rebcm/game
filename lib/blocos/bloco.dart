import 'package:equatable/equatable.dart';

class Bloco with EquatableMixin {
  final String nome;
  final String descricao;
  final String categoria;

  Bloco({required this.nome, required this.descricao, required this.categoria});

  @override
  List<Object?> get props => [nome, descricao, categoria];
}
