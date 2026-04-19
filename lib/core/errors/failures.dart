import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  String get msg;
  @override
  List<Object?> get props => [msg];
}

class LoginFailure extends Failure {
  final String message;

  LoginFailure({this.message = "Falha de login."});

  @override
  String get msg => message;

  @override
  List<Object?> get props => [message];
}

class FileFailure extends Failure {
  final String message;

  FileFailure({required this.message});

  @override
  String get msg => message;

  @override
  List<Object?> get props => [message];
}

class FileFailureRemove extends Failure {
  final String message;

  FileFailureRemove({this.message = "Falha ao salvar o login."});

  @override
  String get msg => message;

  @override
  List<Object?> get props => [message];
}

class CacheException extends Failure {
  final String message;

  CacheException({this.message = "Falha ao remover."});

  @override
  String get msg => message;

  @override
  List<Object?> get props => [message];
}
