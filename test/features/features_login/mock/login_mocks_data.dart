import 'package:flutter_grid_info/features/features_login/data/models/usuario_model.dart';
import 'package:flutter_grid_info/features/features_login/domain/entities/usuario.dart';

class MocksData {
  static final tUsuarioValido = Usuario(
    emailUsuario: 'dev@targetsistemas.com',
    senhaLogin: 'senha@1234',
  );
  static final tUsuarioInvalidoEmail = Usuario(
    emailUsuario: 'devtargetsistemas.com',
    senhaLogin: 'senha@1234',
  );
  static final tUsuarioInvalidoSenha = Usuario(
    emailUsuario: 'dev@targetsistemas.com',
    senhaLogin: 's4',
  );

  static final tUsuarioModel = UsuarioModel(
    emailUsuario: tUsuarioValido.emailUsuario,
    senhaLogin: tUsuarioValido.senhaLogin,
  );
}
