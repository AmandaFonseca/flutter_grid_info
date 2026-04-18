import 'package:flutter/material.dart';

class BoxCard extends StatelessWidget {
  final String id;
  final String texto;
  final VoidCallback onEditar;

  const BoxCard({
    super.key,
    required this.id,
    required this.texto,
    required this.onEditar,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0,
      color: const Color(0xFFF0F0F0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onEditar,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  texto,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(Icons.edit, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
