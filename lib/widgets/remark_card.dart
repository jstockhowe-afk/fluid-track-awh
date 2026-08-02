import 'package:flutter/material.dart';

import 'fluid_card.dart';

class RemarkCard extends StatelessWidget {
  final TextEditingController controller;

  const RemarkCard({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return FluidCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Bemerkung",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: controller,
            maxLines: 4,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Bemerkung eingeben...",
            ),
          ),
        ],
      ),
    );
  }
}