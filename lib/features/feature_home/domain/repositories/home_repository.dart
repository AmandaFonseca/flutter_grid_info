import 'package:dartz/dartz.dart';
import 'package:flutter_grid_info/core/errors/failures.dart';
import 'package:flutter_grid_info/features/feature_home/domain/entities/informacao.dart';

abstract class HomeRepository {
  Future<Either<Failure, Informacao>> salvarInformacao(Informacao info);
  Future<Either<Failure, List<Informacao>>> recuperarInformacoes();
  Future<Either<Failure, Informacao>> excluirInformacao(String id);
  Future<Either<Failure, Informacao>> editarItem(Informacao info);
}
