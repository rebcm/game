import 'package:equatable/equatable.dart';

class AppException with EquatableMixin implements Exception {
  final String message;
  final int code;

  AppException({required this.message, required this.code});

  @override
  List<Object> get props => [message, code];
}
