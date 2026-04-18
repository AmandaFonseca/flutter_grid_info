import 'package:dartz/dartz.dart';
import 'package:flutter_grid_info/core/errors/failures.dart';
import 'package:flutter_grid_info/features/features_login/domain/entities/usuario.dart';
import 'package:flutter_grid_info/features/features_login/domain/repositories/login_repository.dart';
import 'package:flutter_grid_info/features/features_login/domain/usecases/login_usecases/login_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../mock/login_mocks_data.dart';
import 'login_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<LoginRepository>()])
void main() {
  late MockLoginRepository repository;
  late LoginUsecase usecase;

  setUp(() {
    repository = MockLoginRepository();
    usecase = LoginUsecase(repository: repository);
  });

  test('Deve retornar entidade Usuario do lado direito do Either', () async {
    final tUsuario = MocksData.tUsuarioValido;

    when(
      repository.realizarLogin(any),
    ).thenAnswer((_) async => Right<Failure, Usuario>(tUsuario));

    final resultado = await usecase.execute(tUsuario);
    expect(resultado, Right(tUsuario));
    verify(repository.realizarLogin(tUsuario)).called(1);
  });

  test(
    'Deve retornar uma falha (Failure) do lado esquerdo do Either quando o login falhar',
    () async {
      final tUsuarioInvalidoEmail = MocksData.tUsuarioInvalidoEmail;

      when(
        repository.realizarLogin(any),
      ).thenAnswer((_) async => Left<Failure, Usuario>(LoginFailure()));

      final resultado = await usecase.execute(tUsuarioInvalidoEmail);
      expect(resultado, Left(LoginFailure()));

      verify(repository.realizarLogin(tUsuarioInvalidoEmail)).called(1);
    },
  );
}
