import 'package:dartz/dartz.dart';
import 'package:flutter_grid_info/core/errors/failures.dart';
import 'package:flutter_grid_info/features/feature_home/domain/entities/informacao.dart';
import 'package:flutter_grid_info/features/feature_home/domain/repositories/home_repository.dart';
import 'package:flutter_grid_info/features/feature_home/domain/usecases/home_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../mock/home_mocks_data.dart';
import 'home_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<HomeRepository>()])
void main() {
  late MockHomeRepository repository;
  late HomeUsecase usecase;

  setUp(() {
    repository = MockHomeRepository();
    usecase = HomeUsecase(repository: repository);
  });

  test(
    'Deve chamar o repositório para adicionar uma informação com sucesso',
    () async {
      final tInformacao = HomeMocksData.tInformacao;

      when(
        repository.salvarInformacao(any),
      ).thenAnswer((_) async => Right<Failure, Informacao>(tInformacao));

      final result = await usecase.adiciona(tInformacao);
      expect(result, Right(tInformacao));
      verify(repository.salvarInformacao(tInformacao)).called(1);
    },
  );

  test(
    'Deve retornar FileFailure e NÃO chamar o repositório quando o texto da informação for inválido',
    () async {
      final tInformacaoInvalida = HomeMocksData.tInformacaoInvalidoTxt;

      final resultado = await usecase.adiciona(tInformacaoInvalida);
      expect(resultado, Left(FileFailure()));
      verifyNever(repository.salvarInformacao(any));
    },
  );
}
