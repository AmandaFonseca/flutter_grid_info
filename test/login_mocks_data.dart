import 'package:flutter_grid_info/features/features_login/domain/entities/usuario.dart';

class LoginMocksData {
  static final tUsuarioValido = Usuario(
    emailUsuario: 'dev@targetsistemas.com',
    senhaLogin: 'senha@1234',
  );
  static final tUsuarioInvalidoEmail = Usuario(
    emailUsuario: 'dev.targetsistemas.com',
    senhaLogin: 'senha@1234',
  );
  static final tUsuarioInvalidoSenha = Usuario(
    emailUsuario: 'dev@targetsistemas.com',
    senhaLogin: 's4',
  );
}
