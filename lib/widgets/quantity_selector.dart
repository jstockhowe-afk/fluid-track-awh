import 'package:flutter/material.dart';

import 'fluid_card.dart';

class QuantitySelector extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  const QuantitySelector({
    super.key,
    required this.title,
    required this.controller,
    required this.onMinus,
    required this.onPlus,
  });

  @override
  Widget build(BuildContext context) {
    return FluidCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              IconButton.filled(
                onPressed: onMinus,
                icon: const Icon(Icons.remove),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: controller,
                  textAlign: TextAlign.center,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    hintText: "0,0",
                    suffixText: "L",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              IconButton.filled(
                onPressed: onPlus,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}