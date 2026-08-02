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
        children: [
          _tile(
            Icons.opacity,
            "Hydrauliköl",
            machine.hydraulicOil,
          ),

          const Divider(),

          _tile(
            Icons.settings,
            "Gleitbahnöl",
            machine.guidewayOil,
          ),

          const Divider(),

          _tile(
            Icons.water_drop,
            "Kühlschmierstoff",
            machine.coolant,
          ),

          const Divider(),

          _tile(
            Icons.science,
            "Soll-Konzentration",
            "${machine.coolantConcentration.toStringAsFixed(1)} %",
          ),
        ],
      ),
    );
  }

  Widget _tile(
    IconData icon,
    String title,
    String value,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 22,
        child: Icon(icon),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(value.isEmpty ? "-" : value),
    );
  }
}