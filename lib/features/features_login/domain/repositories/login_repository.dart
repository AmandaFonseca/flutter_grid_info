import 'package:dartz/dartz.dart';
import 'package:flutter_grid_info/core/errors/failures.dart';
import 'package:flutter_grid_info/features/features_login/domain/entities/usuario.dart';

abstract class LoginRepository {
  Future<Either<Failure, Usuario>> realizarLogin(Usuario usuario);
}
