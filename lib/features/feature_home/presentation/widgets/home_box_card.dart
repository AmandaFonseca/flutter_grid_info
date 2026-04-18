import 'package:flutter/material.dart';

class BoxCard extends StatelessWidget {
  final IconButton IconeCardEdit;
  final IconButton IconeCardGrafic;
  final String textCardString;
  final void Function(String textoInfo, String idInfo)? onPressed;
  const BoxCard({
    super.key,
    required this.textCardString,
    required this.IconeCardEdit,
    this.onPressed,
    required this.IconeCardGrafic,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(textCardString, style: const TextStyle(fontSize: 16)),
            ),
            IconeCardEdit,
            IconeCardGrafic,
          ],
        ),
      ),
    );
  }
}
