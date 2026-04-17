// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginStore on _LoginStoreBase, Store {
  Computed<bool>? _$podeLogarComputed;

  @override
  bool get podeLogar => (_$podeLogarComputed ??= Computed<bool>(
    () => super.podeLogar,
    name: '_LoginStoreBase.podeLogar',
  )).value;

  late final _$emailAtom = Atom(
    name: '_LoginStoreBase.email',
    context: context,
  );

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$senhaAtom = Atom(
    name: '_LoginStoreBase.senha',
    context: context,
  );

  @override
  String get senha {
    _$senhaAtom.reportRead();
    return super.senha;
  }

  @override
  set senha(String value) {
    _$senhaAtom.reportWrite(value, super.senha, () {
      super.senha = value;
    });
  }

  late final _$carregandoAtom = Atom(
    name: '_LoginStoreBase.carregando',
    context: context,
  );

  @override
  bool get carregando {
    _$carregandoAtom.reportRead();
    return super.carregando;
  }

  @override
  set carregando(bool value) {
    _$carregandoAtom.reportWrite(value, super.carregando, () {
      super.carregando = value;
    });
  }

  late final _$mensagemErroAtom = Atom(
    name: '_LoginStoreBase.mensagemErro',
    context: context,
  );

  @override
  String? get mensagemErro {
    _$mensagemErroAtom.reportRead();
    return super.mensagemErro;
  }

  @override
  set mensagemErro(String? value) {
    _$mensagemErroAtom.reportWrite(value, super.mensagemErro, () {
      super.mensagemErro = value;
    });
  }

  late final _$realizarLoginAsyncAction = AsyncAction(
    '_LoginStoreBase.realizarLogin',
    context: context,
  );

  @override
  Future<void> realizarLogin() {
    return _$realizarLoginAsyncAction.run(() => super.realizarLogin());
  }

  late final _$_LoginStoreBaseActionController = ActionController(
    name: '_LoginStoreBase',
    context: context,
  );

  @override
  void setEmail(String valor) {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
      name: '_LoginStoreBase.setEmail',
    );
    try {
      return super.setEmail(valor);
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSenha(String valor) {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
      name: '_LoginStoreBase.setSenha',
    );
    try {
      return super.setSenha(valor);
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email},
senha: ${senha},
carregando: ${carregando},
mensagemErro: ${mensagemErro},
podeLogar: ${podeLogar}
    ''';
  }
}
