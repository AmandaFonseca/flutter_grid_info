import 'package:flutter/material.dart';
import 'package:flutter_grid_info/features/feature_home/presentation/_stores/home_store.dart';

Future<void> showAddInfoDialog(
  BuildContext context,
  HomeStore store,
  TextEditingController controller,
) {
  return showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text("Salvar"),
          ),
        ],
      );
    },
  );
}
