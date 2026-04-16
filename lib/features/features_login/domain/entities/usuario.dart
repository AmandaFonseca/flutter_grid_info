import 'package:equatable/equatable.dart';

class Usuario extends Equatable {
  final String emailUsuario;
  final String senhaLogin;

  const Usuario({required this.emailUsuario, required this.senhaLogin});

  bool get isEmailValido {
    final emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    return emailRegExp.hasMatch(emailUsuario);
  }

  bool get isSenhaValida => senhaLogin.length >= 6;

  @override
  List<Object?> get props => [emailUsuario, senhaLogin];
}
