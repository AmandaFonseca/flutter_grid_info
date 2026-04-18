import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_grid_info/features/feature_home/domain/entities/informacao.dart';
import 'package:flutter_grid_info/features/feature_home/domain/usecases/home_usecase.dart';
part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  final HomeUsecase _homeUsecase;

  _HomeStoreBase(this._homeUsecase);

  @observable
  String textoInput = "";

  @observable
  ObservableList<Informacao> listaInformacoes = ObservableList<Informacao>();

  @observable
  bool carregando = false;

  @observable
  String? mensagemErro;

  @computed
  bool get podeAdicionar => textoInput.length >= 3;

  @action
  void setTextoInput(String valor) => textoInput = valor;

  @action
  Future<void> inicializarDados() async {
    final resultado = await _homeUsecase.recuperarInformacoes();
    resultado.fold(
      (failure) {
        print("Erro ao carregar dados: $failure");
      },
      (lista) {
        listaInformacoes.clear();
        listaInformacoes.addAll(lista);
      },
    );
  }

  @action
  Future<void> adicionarItem(
    BuildContext context,
    TextEditingController controller,
  ) async {
    carregando = true;
    mensagemErro = null;

    int numeroAleatorio = Random().nextInt(9000) + 1000;
    String stringNumeroAleatorio = numeroAleatorio.toString();

    final novaInfo = Informacao(
      idInfo: stringNumeroAleatorio,
      textoInfo: controller.text,
      qtdEdicoesInfo: 0,
    );

    final resultado = await _homeUsecase.adiciona(novaInfo);
    print(resultado);
    resultado.fold(
      (failure) {
        mensagemErro = "Erro ao salvar: ${failure.toString()}";
      },
      (sucesso) {
        listaInformacoes.add(sucesso);
        textoInput = "";
        Navigator.pop(context);
      },
    );

    carregando = false;
  }
}
