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

  Future<void> _showEditInfoDialog(String textoAtual, String id) async {
    final TextEditingController controller = TextEditingController(
      text: textoAtual,
    );

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Observer(
              builder: (_) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Editar Dados",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                        onPressed: store.carregando
                            ? null
                            : () async {
                                final confirmou = await _confirmarExclusao();
                                if (confirmou) {
                                  final excluiu = await store.excluirItem(id);
                                  if (excluiu && context.mounted) {
                                    Navigator.pop(context);
                                  }
                                }
                              },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: controller,
                    maxLines: 6,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: store.carregando
                              ? null
                              : () => Navigator.pop(context),
                          child: const Text("Sair"),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff3E3030),
                          ),
                          onPressed: store.carregando
                              ? null
                              : () async {
                                  final salvou = await store.editarItem(
                                    id,
                                    controller.text,
                                  );
                                  if (salvou && context.mounted) {
                                    Navigator.pop(context);
                                  }
                                },
                          child: store.carregando
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  "Salvar",
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<bool> _confirmarExclusao() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Excluir?"),
            content: const Text(
              "Tem certeza que deseja apagar esta informação?",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Não"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text("Sim", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ) ??
        false;
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

            return Container(
              child: ListView.builder(
                controller: _listScrollController,
                padding: const EdgeInsets.all(12),
                itemCount: store.listaInformacoes.length,
                itemBuilder: (_, index) {
                  final item = store.listaInformacoes[index];

                  return Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item.textoInfo,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),

                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              _showEditInfoDialog(item.textoInfo, item.idInfo);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.bar_chart),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
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
