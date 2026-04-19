import 'package:dartz/dartz.dart';
import 'package:flutter_grid_info/core/errors/failures.dart';
import 'package:flutter_grid_info/features/feature_home/data/datasources/home_local_data_source/home_local_data_source.dart';
import 'package:flutter_grid_info/features/feature_home/data/models/informacao_model.dart';
import 'package:flutter_grid_info/features/feature_home/domain/entities/informacao.dart';
import 'package:flutter_grid_info/features/feature_home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDataSource dataSource;

  HomeRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, Informacao>> salvarInformacao(Informacao info) async {
    try {
      final model = InformacaoModel.fromEntity(info);

      final sucesso = await dataSource.salvarInformacao(model);

      if (sucesso) {
        return Right(info);
      } else {
        return Left(FileFailure(message: 'Erro ao salvar a informação.'));
      }
    } catch (e) {
      return Left(FileFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Informacao>>> recuperarInformacoes() async {
    try {
      final resultado = await dataSource.recuperarInformacoes();
      return Right(resultado);
    } catch (e) {
      return Left(FileFailure(message: 'Erro ao recuperar a informação.'));
    }
  }

  @override
  Future<Either<Failure, Informacao>> excluirInformacao(String id) async {
    try {
      await dataSource.removeItem(id);

      return Right(Informacao(idInfo: id, textoInfo: '', qtdEdicoesInfo: 0));
    } catch (e) {
      return Left(FileFailure(message: 'Erro ao excluir a informação.'));
    }
  }

  @override
  Future<Either<Failure, Informacao>> editarItem(Informacao info) async {
    try {
      final model = InformacaoModel(
        idInfo: info.idInfo,
        textoInfo: info.textoInfo,
        qtdEdicoesInfo: info.qtdEdicoesInfo,
      );

      final sucesso = await dataSource.editarItem(model);

      if (sucesso) {
        return Right(info);
      } else {
        return Left(FileFailureRemove());
      }
    } catch (e) {
      return Left(FileFailure(message: e.toString()));
    }
  }
}
