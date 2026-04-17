import 'package:flutter/material.dart';
import 'package:flutter_grid_info/features/features_login/presentation/_stores/login_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../core/injections/container_injection.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final store = getIt<LoginStore>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  onChanged: store.setEmail,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Senha",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  obscureText: true,
                  onChanged: store.setSenha,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                const SizedBox(height: 24),
              ],
            ),
            Observer(
              builder: (_) {
                if (store.mensagemErro != null) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Text(
                      store.mensagemErro!,
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            Observer(
              builder: (_) {
                return ElevatedButton(
                  onPressed: store.podeLogar && !store.carregando
                      ? () => store.realizarLogin()
                      : null,
                  child: store.carregando
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text("Entrar"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
