import 'package:flutter/material.dart';
import 'package:flutter_grid_info/core/components/themes/custom_colors.dart';
import 'package:flutter_grid_info/features/features_login/presentation/_stores/login_store.dart';
import 'package:flutter_grid_info/features/features_login/presentation/widgets/login_screen_text_field.dart';
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
              children: [
                Text(
                  "Sistema de Gestão de Textos",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 32),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: CustomColors.gray700,
                  ),
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  label: "E-mail",
                  onChanged: store.setEmail,
                  errorText: () => store.erroEmail,
                  keyboardType: TextInputType.emailAddress,
                  isPassword: false,
                  obscureText: false,
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
                    color: CustomColors.gray700,
                  ),
                ),
                const SizedBox(height: 8),
                Observer(
                  builder: (_) => CustomTextField(
                    label: "Senha",
                    onChanged: store.setSenha,
                    errorText: () => store.erroSenha,
                    isPassword: true,
                    obscureText: !store.senhaVisivel,
                    onSuffixIconPressed: store.alternarVisibilidadeSenha,
                  ),
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
                      style: TextStyle(color: CustomColors.vermilion),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            Observer(
              builder: (_) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: store.podeLogar && !store.carregando
                          ? () => store.realizarLogin(
                              onSuccess: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/home',
                                );
                              },
                            )
                          : null,
                      child: store.carregando
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text("Entrar"),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
