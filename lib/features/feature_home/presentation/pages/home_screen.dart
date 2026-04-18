import 'package:flutter/material.dart';
import 'package:flutter_grid_info/core/injections/container_injection.dart';
import 'package:flutter_grid_info/features/feature_home/presentation/_stores/home_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final store = getIt<HomeStore>();
  final ScrollController _listScrollController = ScrollController();
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    store.inicializarDados();
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    super.dispose();
  }

  Future<void> _logout(BuildContext context) async {
    final prefs = getIt<SharedPreferences>();
    await prefs.remove('is_logged');

    if (context.mounted) {
      Navigator.pushReplacementNamed(context, "/");
    }
  }

  void _showAddInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Nova Informação',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: TextField(
              controller: controller,
              maxLines: 6,
              decoration: const InputDecoration(
                hintText: "Digite seu texto aqui...",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(16),
              ),
            ),
          ),
          actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () async {
                await store.adicionarItem(context, controller);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff3E3030),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: const Text("Salvar"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Informações"),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xfff0f0f0),
        actions: [
          IconButton(
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      body: SafeArea(
        child: Observer(
          builder: (_) {
            if (store.listaInformacoes.isEmpty) {
              return const Center(
                child: Text(
                  'Nenhuma informação salva.',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }

            return ListView.builder(
              controller: _listScrollController,
              padding: const EdgeInsets.all(12),
              itemCount: store.listaInformacoes.length,
              itemBuilder: (_, index) {
                final item = store.listaInformacoes[index];

                return Card(
                  elevation: 4,
                  child: Center(child: Text(item.textoInfo)),
                );
              },
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddInfoDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
