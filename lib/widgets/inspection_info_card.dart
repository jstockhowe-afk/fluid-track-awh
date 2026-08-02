import 'package:flutter/material.dart';

import '../models/machine.dart';
import 'fluid_card.dart';

class InspectionInfoCard extends StatelessWidget {
  final Machine machine;

  const InspectionInfoCard({
    super.key,
    required this.machine,
  });

  @override
  Widget build(BuildContext context) {
    return FluidCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Maschinendaten",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          _row("Hydrauliköl", machine.hydraulicOil),

          const Divider(),

          _row("Gleitbahnöl", machine.guidewayOil),

          const Divider(),

          _row("Kühlschmierstoff", machine.coolant),

          const Divider(),

          _row(
            "Soll-Konzentration",
            "${machine.coolantConcentration.toStringAsFixed(1)} %",
),
        ],
      ),
    );
  }

  Widget _row(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(value),
        ],
      ),
    );
  }
}