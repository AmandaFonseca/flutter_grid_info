import 'package:dartz/dartz.dart';
import 'package:flutter_grid_info/core/errors/failures.dart';
import 'package:flutter_grid_info/features/feature_home/domain/entities/informacao.dart';
import 'package:flutter_grid_info/features/feature_home/domain/repositories/home_repository.dart';

class HomeUsecase {
  String msg = "O texto deve ter entre 3 e 100 caracteres.";
  final HomeRepository repository;

  HomeUsecase({required this.repository});

  Future<Either<Failure, Informacao>> adiciona(Informacao info) async {
    if (!info.isTextoInfoValido) {
      return Left(FileFailure(message: msg));
    }
    return await repository.salvarInformacao(info);
  }

  Future<Either<Failure, List<Informacao>>> recuperarInformacoes() async {
    return await repository.recuperarInformacoes();
  }

  Future<Either<Failure, Informacao>> excluirInformacao(String id) async {
    return await repository.excluirInformacao(id);
  }

  Future<Either<Failure, Informacao>> editarItem(Informacao info) async {
    if (!info.isTextoInfoValido) {
      return Left(FileFailure(message: msg));
    }
    return await repository.editarItem(info);
  }
}
