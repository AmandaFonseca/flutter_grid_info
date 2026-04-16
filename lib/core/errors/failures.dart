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
