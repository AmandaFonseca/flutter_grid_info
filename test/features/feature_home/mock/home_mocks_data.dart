import 'package:flutter_grid_info/features/feature_home/data/models/informacao_model.dart';
import 'package:flutter_grid_info/features/feature_home/domain/entities/informacao.dart';

class HomeMocksData {
  static final tInformacao = Informacao(
    idInfo: '1',
    textoInfo: 'Teste de Informação',
    qtdEdicoesInfo: 0,
  );
  static final tInformacaoInvalidoTxt = Informacao(
    idInfo: '2',
    textoInfo: 'T',
    qtdEdicoesInfo: 0,
  );

  static final tInformacaoModel = InformacaoModel.fromEntity(tInformacao);
}
