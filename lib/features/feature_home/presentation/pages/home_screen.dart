import 'package:flutter/material.dart';
import 'package:flutter_grid_info/core/injections/container_injection.dart';
import 'package:flutter_grid_info/features/feature_home/presentation/_stores/home_store.dart';
import 'package:flutter_grid_info/features/feature_home/presentation/widgets/home_box_card.dart';
import 'package:flutter_grid_info/features/feature_home/presentation/widgets/home_modal/home_add_info_dialog.dart';
import 'package:flutter_grid_info/features/feature_home/presentation/widgets/home_modal/home_edit_info_dialog.dart';
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
                return BoxCard(
                  textCardString: item.textoInfo,
                  iconeCardEdit: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      showEditInfoDialog(
                        context,
                        store,
                        item.idInfo,
                        item.textoInfo,
                      );
                    },
                  ),
                  iconeCardGrafic: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.bar_chart),
                  ),
                );
              },
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddInfoDialog(context, store, controller),
        child: const Icon(Icons.add),
      ),
    );
  }
}
