import 'package:dartz/dartz.dart';
import 'package:flutter_grid_info/core/errors/failures.dart';
import 'package:flutter_grid_info/features/features_login/domain/entities/usuario.dart';
import 'package:flutter_grid_info/features/features_login/domain/repositories/login_repository.dart';

class LoginUsecase {
  final LoginRepository repository;

  LoginUsecase({required this.repository});

  Future<Either<Failure, Usuario>> execute(Usuario usuario) async {
    return await repository.realizarLogin(usuario);
  }
}
