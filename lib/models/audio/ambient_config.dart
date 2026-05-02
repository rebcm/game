import 'package:equatable/equatable.dart';

class AmbientConfig extends Equatable {
  final String ambientPath;

  const AmbientConfig({required this.ambientPath});

  @override
  List<Object> get props => [ambientPath];
}
