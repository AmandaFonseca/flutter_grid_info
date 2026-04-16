import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_grid_info/features/features_login/data/datasources/login_local_data_source/login_local_data_source.dart';
import 'package:flutter_grid_info/features/features_login/data/models/usuario_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginLocalDataSourceImpl implements LoginLocalDataSource {
  final SharedPreferences sharedPreferences;
  LoginLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UsuarioModel> login(String email, String senha) async {
    final envEmail = dotenv.env['LOGIN_EMAIL'] ?? 'admin@targetsistemas.com';
    final envPass = dotenv.env['LOGIN_PASSWORD'] ?? 'senha@1234';

    if (email == envEmail && senha == envPass) {
      return UsuarioModel(emailUsuario: email, senhaLogin: senha);
    } else {
      throw Exception("Credenciais Inválidas");
    }
  }
}
