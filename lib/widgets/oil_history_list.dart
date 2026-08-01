import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/oil_entry.dart';

class OilHistoryList extends StatelessWidget {
  final List<OilEntry> entries;

  const OilHistoryList({
    super.key,
    required this.entries,
  });

  Color _mediumColor(String medium) {
    switch (medium) {
      case "Hydrauliköl":
        return Colors.blue;
      case "Gleitbahnöl":
        return Colors.orange;
      case "Kühlschmierstoff":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _mediumIcon(String medium) {
    switch (medium) {
      case "Hydrauliköl":
        return Icons.oil_barrel;
      case "Gleitbahnöl":
        return Icons.opacity;
      case "Kühlschmierstoff":
        return Icons.water_drop;
      default:
        return Icons.inventory_2;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return const Card(
        child: ListTile(
          leading: Icon(Icons.history),
          title: Text("Noch keine Buchungen"),
          subtitle: Text(
            "Für diese Maschine wurden noch keine Nachfüllungen erfasst.",
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: entries.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final entry = entries[index];

        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(14),
            leading: CircleAvatar(
              backgroundColor: _mediumColor(entry.medium),
              child: Icon(
                _mediumIcon(entry.medium),
                color: Colors.white,
              ),
            ),
            title: Text(
              entry.medium,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Menge: ${entry.liters.toStringAsFixed(1)} Liter",
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat(
                      'dd.MM.yyyy • HH:mm',
                    ).format(entry.dateTime),
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                  if (entry.comment.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      entry.comment,
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}