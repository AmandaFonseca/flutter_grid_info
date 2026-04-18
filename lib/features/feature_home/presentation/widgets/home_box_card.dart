import 'package:flutter/material.dart';

class BoxCard extends StatelessWidget {
  final IconButton iconeCardEdit;
  final IconButton iconeCardGrafic;
  final String textCardString;
  const BoxCard({
    super.key,
    required this.textCardString,
    required this.iconeCardEdit,
    required this.iconeCardGrafic,
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
            iconeCardEdit,
            iconeCardGrafic,
          ],
        ),
      ),
    );
  }
}
