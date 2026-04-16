import 'package:dartz/dartz.dart';
import 'package:flutter_grid_info/core/errors/failures.dart';
import 'package:flutter_grid_info/features/features_login/data/datasources/login_local_data_source/login_local_data_source.dart';
import 'package:flutter_grid_info/features/features_login/data/repositories/login_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../login_mocks_data.dart';
import 'login_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<LoginLocalDataSource>()])
void main() {
  late MockLoginLocalDataSource dataSource;
  late LoginRepositoryImpl dataRepository;

  setUp(() {
    dataSource = MockLoginLocalDataSource();
    dataRepository = LoginRepositoryImpl(dataSource: dataSource);
  });

  test('Deve retornar entidade Usuario do lado direito do Either', () async {
    final tUsuario = LoginMocksData.tUsuarioValido;
    final tUsuarioModel = LoginMocksData.tUsuarioModel;
    when(dataSource.login(any, any)).thenAnswer((_) async => tUsuarioModel);

    final resultado = await dataRepository.realizarLogin(tUsuario);
    expect(resultado, Right(tUsuarioModel));
    verify(
      dataSource.login(tUsuario.emailUsuario, tUsuario.senhaLogin),
    ).called(1);
  });

  test(
    'Deve retornar uma falha (Failure) do lado esquerdo do Either quando o Datasource lançar uma Exception',
    () async {
      final tUsuario = LoginMocksData.tUsuarioValido;

      when(dataSource.login(any, any)).thenThrow(Exception());

      final resultado = await dataRepository.realizarLogin(tUsuario);
      expect(resultado, isA<Left<Failure, dynamic>>());
      expect(resultado.fold((l) => l, (r) => r), isA<LoginFailure>());
      verify(dataSource.login(any, any)).called(1);
    },
  );
}
