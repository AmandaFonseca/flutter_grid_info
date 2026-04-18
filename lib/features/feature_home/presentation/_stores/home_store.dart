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

  @action
  Future<bool> excluirItem(String id) async {
    carregando = true;

    final resultado = await _homeUsecase.excluirInformacao(id);

    return resultado.fold(
      (failure) {
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
  Future<bool> editarItem(String id, String novoTexto) async {
    carregando = true;

    final infoEditada = Informacao(
      idInfo: id,
      textoInfo: novoTexto,
      qtdEdicoesInfo: 0,
    );

    final result = await _homeUsecase.editarItem(infoEditada);

    return result.fold(
      (failure) {
        carregando = false;
        return false;
      },
      (infoSucesso) {
        final index = listaInformacoes.indexWhere((item) => item.idInfo == id);
        if (index != -1) {
          listaInformacoes[index] = infoSucesso;
        }
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
        mensagemErro = "Erro ao salvar: ${failure.toString()}";
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
