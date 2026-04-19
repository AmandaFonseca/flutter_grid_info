import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grid_info/core/injections/container_injection.dart';
import 'package:flutter_grid_info/features/feature_home/presentation/_stores/home_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomeGraficScreen extends StatelessWidget {
  const HomeGraficScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = getIt<HomeStore>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Estatísticas"),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Observer(
        builder: (_) {
          final dados = store.estatisticasAlfanumericas;
          final temDados =
              (dados['Letras'] ?? 0) > 0 || (dados['Números'] ?? 0) > 0;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildResumo(store),
                const SizedBox(height: 32),
                const Text(
                  "Proporção Letras vs Números",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 250,
                  child: temDados
                      ? PieChart(
                          PieChartData(
                            sectionsSpace: 2,
                            centerSpaceRadius: 40,
                            sections: [
                              PieChartSectionData(
                                value: (dados['Letras'] ?? 0).toDouble(),
                                title: 'Letras\n${dados['Letras']}',
                                color: Colors.blue,
                                radius: 50,
                                titleStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              PieChartSectionData(
                                value: (dados['Números'] ?? 0).toDouble(),
                                title: 'Números\n${dados['Números']}',
                                color: Colors.orange,
                                radius: 50,
                                titleStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      : const Center(
                          child: Text(
                            "Adicione textos com letras ou números para ver o gráfico",
                          ),
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildResumo(HomeStore store) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _metricRow("Quantidade de Linhas:", "${store.totalLinhas}"),
            const Divider(),
            _metricRow("Edições Totais:", "${store.totalEdicoes}"),
            const Divider(),
            _metricRow("Caracteres Totais:", "${store.totalCaracteres}"),
          ],
        ),
      ),
    );
  }

  Widget _metricRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
