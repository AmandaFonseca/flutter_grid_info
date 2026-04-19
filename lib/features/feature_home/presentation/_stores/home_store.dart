import 'package:mobx/mobx.dart';
import 'package:flutter_grid_info/features/feature_home/domain/entities/informacao.dart';
import 'package:flutter_grid_info/features/feature_home/domain/usecases/home_usecase.dart';
part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  final HomeUsecase _homeUsecase;
  _HomeStoreBase(this._homeUsecase);

  @observable
  ObservableList<Informacao> listaInformacoes = ObservableList<Informacao>();

  @observable
  bool carregando = false;

  @observable
  String? mensagemErro;

  @computed
  int get totalLinhas => listaInformacoes.length;

  @computed
  int get totalEdicoes =>
      listaInformacoes.fold(0, (sum, item) => sum + item.qtdEdicoesInfo);

  @computed
  int get totalCaracteres =>
      listaInformacoes.fold(0, (sum, item) => sum + item.textoInfo.length);

  @computed
  Map<String, int> get estatisticasAlfanumericas {
    int letras = 0;
    int numeros = 0;

    for (var item in listaInformacoes) {
      final texto = item.textoInfo;
      letras += RegExp(r'[a-zA-Z]').allMatches(texto).length;
      numeros += RegExp(r'[0-9]').allMatches(texto).length;
    }

    return {'Letras': letras, 'Números': numeros};
  }

  @action
  void limparErro() {
    mensagemErro = null;
  }

  @action
  Future<void> inicializarDados() async {
    final resultado = await _homeUsecase.recuperarInformacoes();
    resultado.fold(
      (failure) {
        mensagemErro =
            "Não foi possível carregar seus dados. Verifique o armazenamento.";
      },
      (lista) {
        listaInformacoes.clear();
        listaInformacoes.addAll(lista);
      },
    );
  }

  @action
  Future<bool> editarItem(
    String id,
    String novoTexto,
    int qtdEdicoesInfo,
  ) async {
    carregando = true;
    mensagemErro = null;

    final infoEditada = Informacao(
      idInfo: id,
      textoInfo: novoTexto,
      qtdEdicoesInfo: qtdEdicoesInfo + 1,
    );

    final result = await _homeUsecase.editarItem(infoEditada);

    return result.fold(
      (failure) {
        mensagemErro = failure.msg;
        carregando = false;
        return false;
      },
      (infoSucesso) {
        final index = listaInformacoes.indexWhere((item) => item.idInfo == id);
        if (index != -1) {
          listaInformacoes[index] = infoSucesso;
        }
        carregando = false;
        mensagemErro = null;
        return true;
      },
    );
  }

  @action
  Future<bool> excluirItem(String id) async {
    carregando = true;
    mensagemErro = null;

    final resultado = await _homeUsecase.excluirInformacao(id);

    return resultado.fold(
      (failure) {
        mensagemErro = failure.msg;
        carregando = false;
        return false;
      },
      (sucesso) {
        listaInformacoes.removeWhere((item) => item.idInfo == id);
        carregando = false;
        return true;
      },
    );
  }

  @action
  Future<bool> adicionarItem(String texto) async {
    carregando = true;
    mensagemErro = null;

    String idAleatorio = DateTime.now().millisecondsSinceEpoch.toString();
    final novaInfo = Informacao(
      idInfo: idAleatorio,
      textoInfo: texto,
      qtdEdicoesInfo: 0,
    );

    final resultado = await _homeUsecase.adiciona(novaInfo);

    return resultado.fold(
      (failure) {
        mensagemErro = failure.msg;
        carregando = false;
        return false;
      },
      (sucesso) {
        listaInformacoes.add(sucesso);
        carregando = false;
        return true;
      },
    );
  }
}
