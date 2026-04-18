import 'package:dartz/dartz.dart';
import 'package:flutter_grid_info/core/errors/failures.dart';
import 'package:flutter_grid_info/features/feature_home/data/datasources/home_local_data_source/home_local_data_source.dart';
import 'package:flutter_grid_info/features/feature_home/data/repositories/home_repository_impl.dart';
import 'package:flutter_grid_info/features/feature_home/domain/entities/informacao.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../mock/home_mocks_data.dart';
import 'home_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<HomeLocalDataSource>()])
void main() {
  late MockHomeLocalDataSource dataSource;
  late HomeRepositoryImpl repository;

  setUp(() {
    dataSource = MockHomeLocalDataSource();
    repository = HomeRepositoryImpl(dataSource: dataSource);
  });

  test(
    'Deve retornar entidade Informacao do lado direito do Either quando salvar com sucesso',
    () async {
      final tInformacao = HomeMocksData.tInformacao;

      when(dataSource.salvarInformacao(any)).thenAnswer((_) async => true);
      final resultado = await repository.salvarInformacao(tInformacao);
      expect(resultado, Right<Failure, Informacao>(tInformacao));
      verify(dataSource.salvarInformacao(any)).called(1);
    },
  );

  test(
    'Deve retornar FileFailure do lado esquerdo quando o DataSource falhar',
    () async {
      final tInformacao = HomeMocksData.tInformacao;

      when(dataSource.salvarInformacao(any)).thenAnswer((_) async => false);
      final resultado = await repository.salvarInformacao(tInformacao);
      expect(resultado, Left<Failure, Informacao>(FileFailure()));
    },
  );
}
