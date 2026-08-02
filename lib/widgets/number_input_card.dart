import 'package:flutter/material.dart';

import 'fluid_card.dart';

class NumberInputCard extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String? suffix;

  const NumberInputCard({
    super.key,
    required this.title,
    required this.controller,
    this.suffix,
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

          TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
            ),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              suffixText: suffix,
            ),
          ),
        ],
      ),
    );
  }
}