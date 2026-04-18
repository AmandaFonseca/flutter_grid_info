import 'package:flutter_grid_info/features/feature_home/data/models/informacao_model.dart';

abstract class HomeLocalDataSource {
  Future<bool> salvarInformacao(InformacaoModel info);
  Future<List<InformacaoModel>> recuperarInformacoes();
}
