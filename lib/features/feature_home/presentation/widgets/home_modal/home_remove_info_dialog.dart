import 'package:flutter/material.dart';
import 'package:flutter_grid_info/core/components/themes/custom_colors.dart';

Future<bool> showConfirmRemoveDialog(BuildContext context) async {
  return await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Excluir?"),
          content: const Text("Tem certeza que deseja apagar esta informação?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Não"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(
                "Sim",
                style: TextStyle(color: CustomColors.vermilion),
              ),
            ),
          ],
        ),
      ) ??
      false;
}
