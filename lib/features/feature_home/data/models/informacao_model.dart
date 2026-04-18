import 'package:flutter_grid_info/features/feature_home/domain/entities/informacao.dart';

class InformacaoModel extends Informacao {
  const InformacaoModel({
    required super.idInfo,
    required super.textoInfo,
    required super.qtdEdicoesInfo,
  });

  factory InformacaoModel.fromEntity(Informacao entity) {
    return InformacaoModel(
      idInfo: entity.idInfo,
      textoInfo: entity.textoInfo,
      qtdEdicoesInfo: entity.qtdEdicoesInfo,
    );
  }

  factory InformacaoModel.fromMap(Map<String, dynamic> map) {
    return InformacaoModel(
      idInfo: map['idInfo'] ?? '',
      textoInfo: map['textoInfo'] ?? '',
      qtdEdicoesInfo: map['qtdEdicoesInfo'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idInfo': idInfo,
      'textoInfo': textoInfo,
      'qtdEdicoesInfo': qtdEdicoesInfo,
    };
  }
}
