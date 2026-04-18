import 'package:flutter/material.dart';
import 'package:flutter_grid_info/features/feature_home/presentation/pages/home_grafic_screen.dart';
import 'package:flutter_grid_info/features/feature_home/presentation/pages/home_screen.dart';
import 'package:flutter_grid_info/features/features_login/presentation/pages/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './core/injections/container_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpContainer();
  runApp(GridInfo());
}

class GridInfo extends StatelessWidget {
  final prefs = getIt<SharedPreferences>();
  bool get estaLogado => prefs.getBool('is_logged') ?? false;

  GridInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grid Info',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: estaLogado ? Home() : const LoginScreen(),

      routes: {
        '/login': (context) => const LoginScreen(),
        '/grafic': (context) => HomeGraficScreen(),
        '/home': (context) => Home(),
      },
    );
  }
}
