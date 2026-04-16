import 'package:dartz/dartz.dart';
import 'package:flutter_grid_info/core/errors/failures.dart';
import 'package:flutter_grid_info/features/features_login/data/datasources/login_local_data_source/login_local_data_source.dart';
import 'package:flutter_grid_info/features/features_login/domain/entities/usuario.dart';
import 'package:flutter_grid_info/features/features_login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginLocalDataSource dataSource;
  LoginRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, Usuario>> realizarLogin(Usuario usuario) async {
    try {
      final model = await dataSource.login(
        usuario.emailUsuario,
        usuario.senhaLogin,
      );
      return Right(model);
    } catch (e) {
      return Left(LoginFailure(message: "Erro: Credenciais incorretas."));
    }
  }
}
