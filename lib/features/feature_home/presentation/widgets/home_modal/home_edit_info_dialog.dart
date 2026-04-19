import 'package:flutter/material.dart';
import 'package:flutter_grid_info/core/components/themes/custom_colors.dart';
import 'package:flutter_grid_info/features/feature_home/presentation/_stores/home_store.dart';
import 'package:flutter_grid_info/features/feature_home/presentation/widgets/home_modal/home_remove_info_dialog.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

Future<void> showEditInfoDialog(
  BuildContext context,
  HomeStore store,
  String id,
  String textoAtual,
  int qtdEdicoesInfo,
) async {
  final controller = TextEditingController(text: textoAtual);
  store.limparErro();
  await showDialog(
    context: context,
    barrierDismissible: !store.carregando,
    builder: (_) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                      "Editar o Texto",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete_outline,
                        color: CustomColors.vermilion,
                      ),
                      onPressed: store.carregando
                          ? null
                          : () async {
                              final confirmou = await showConfirmRemoveDialog(
                                context,
                              );

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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (store.mensagemErro != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Center(
                          child: Text(
                            store.mensagemErro!,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: CustomColors.vermilion),
                          ),
                        ),
                      ),
                  ],
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
                          // backgroundColor: const Color(0xff3E3030),
                        ),
                        onPressed: store.carregando
                            ? null
                            : () async {
                                final salvou = await store.editarItem(
                                  id,
                                  controller.text,
                                  qtdEdicoesInfo,
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
                            : Text(
                                "Salvar",
                                style: TextStyle(color: CustomColors.white),
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
