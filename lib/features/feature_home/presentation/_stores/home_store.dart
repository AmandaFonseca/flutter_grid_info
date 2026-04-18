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
  Future<void> adicionarItem() async {
    carregando = true;
    mensagemErro = null;

    final novaInfo = Informacao(
      idInfo: '1',
      textoInfo: textoInput,
      qtdEdicoesInfo: 0,
    );

    final resultado = await _homeUsecase.adiciona(novaInfo);

    resultado.fold(
      (failure) {
        mensagemErro = "Erro ao salvar: ${failure.toString()}";
      },
      (sucesso) {
        listaInformacoes.add(sucesso);
        textoInput = "";
      },
    );

    carregando = false;
  }
}
