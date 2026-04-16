import 'package:flutter_grid_info/features/features_login/data/models/usuario_model.dart';

abstract class LoginLocalDataSource {
  Future<UsuarioModel> login(String email, String senha);
}
