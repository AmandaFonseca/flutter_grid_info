import 'package:flutter/material.dart';
import 'package:flutter_grid_info/core/injections/container_injection.dart';

class HomeGraficScreen extends StatelessWidget {
  const HomeGraficScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Informações"),
        backgroundColor: const Color(0xfff0f0f0),
        leading: BackButton(
          onPressed: () => Navigator.pushReplacementNamed(context, "/home"),
        ),
        actions: [],
      ),
    );
  }
}
