import 'package:flutter/material.dart';
import 'package:flutter_grid_info/features/feature_home/presentation/pages/home_screen.dart';
import 'package:flutter_grid_info/features/features_login/presentation/pages/login_screen.dart';
import './core/injections/container_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpContainer();
  runApp(const GridInfo());
}

class GridInfo extends StatelessWidget {
  const GridInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grid Info',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const Home(),
      },
      //home: const LoginScreen(),
    );
  }
}
