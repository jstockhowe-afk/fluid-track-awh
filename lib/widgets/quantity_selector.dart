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

          const SizedBox(height: 18),

          Row(
            children: [
              SizedBox(
                width: 55,
                height: 55,
                child: ElevatedButton(
                  onPressed: onMinus,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: EdgeInsets.zero,
                  ),
                  child: const Icon(Icons.remove),
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: SizedBox(
                  height: 56,
                  child: TextField(
                    controller: controller,
                    textAlign: TextAlign.center,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      suffixText: "L",
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 16),

              SizedBox(
                width: 55,
                height: 55,
                child: ElevatedButton(
                  onPressed: onPlus,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: EdgeInsets.zero,
                  ),
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: onMinus,
                child: const Text("-0,5 L"),
              ),
              const SizedBox(width: 12),
              FilledButton(
                onPressed: onPlus,
                child: const Text("+0,5 L"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}