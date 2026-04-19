import 'package:equatable/equatable.dart';

class Informacao extends Equatable {
  final String idInfo;
  final String textoInfo;
  final int qtdEdicoesInfo;

  const Informacao({
    required this.idInfo,
    required this.textoInfo,
    required this.qtdEdicoesInfo,
  });

  int get totalCaracteresInfo => textoInfo.length;

  int get qtdLetrasInfo => textoInfo
      .replaceAll(RegExp(r'[a-zA-Zá-úÁ-Úà-ùÀ-Ùã-õÃ-Õâ-ûÂ-ÛçÇ]'), '')
      .length;

  int get qtdNumerosInfo => textoInfo.replaceAll(RegExp(r'[^0-9]'), '').length;

  bool get isTextoInfoValido {
    final texto = textoInfo.trim();
    return texto.length >= 3 && texto.length <= 100;
  }

  @override
  List<Object?> get props => [idInfo, textoInfo, qtdEdicoesInfo];
}
