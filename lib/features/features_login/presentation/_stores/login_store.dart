import 'package:mobx/mobx.dart';
import 'package:flutter_grid_info/features/features_login/domain/entities/usuario.dart';
import 'package:flutter_grid_info/features/features_login/domain/usecases/login_usecases/login_usecase.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  final LoginUsecase _loginUsecase;

  _LoginStoreBase(this._loginUsecase);

  @observable
  String email = "";

  @observable
  String senha = "";

  @observable
  bool carregando = false;

  @observable
  String? mensagemErro;

  @computed
  bool get podeLogar {
    final usuarioProxy = Usuario(emailUsuario: email, senhaLogin: senha);
    return usuarioProxy.isEmailValido && usuarioProxy.isSenhaValida;
  }

  @action
  void setEmail(String valor) => email = valor;

  @action
  void setSenha(String valor) => senha = valor;

  @action
  Future<void> realizarLogin() async {
    carregando = true;
    mensagemErro = null;

    final usuarioParaLogin = Usuario(emailUsuario: email, senhaLogin: senha);
    final resultado = await _loginUsecase.execute(usuarioParaLogin);

    resultado.fold(
      (failure) {
        mensagemErro = failure.msg;
        carregando = false;
      },
      (usuarioSucesso) {
        carregando = false;
        print(
          "Login realizado com sucesso para: ${usuarioSucesso.emailUsuario}",
        );
      },
    );
  }
}
