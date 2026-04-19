import 'package:flutter/material.dart';
import 'package:flutter_grid_info/core/components/themes/custom_colors.dart';
import 'package:flutter_grid_info/features/feature_home/presentation/_stores/home_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

Future<void> showAddInfoDialog(
  BuildContext context,
  HomeStore store,
  TextEditingController controller,
) {
  store.limparErro();
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return Observer(
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Inserir um Texto',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: CustomColors.gray800,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                maxLines: 6,
                decoration: const InputDecoration(
                  hintText: "Digite seu texto aqui...",
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
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
          actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              onPressed: store.carregando
                  ? null
                  : () async {
                      final sucesso = await store.adicionarItem(
                        controller.text,
                      );

                      if (sucesso && dialogContext.mounted) {
                        controller.clear();
                        Navigator.pop(dialogContext);
                      }
                    },
              child: store.carregando
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text("Salvar"),
            ),
          ],
        ),
      );
    },
  );
}
