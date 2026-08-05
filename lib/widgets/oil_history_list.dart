import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/inspection_entry.dart';

class OilHistoryList extends StatelessWidget {
  final List<InspectionEntry> entries;

  const OilHistoryList({
    super.key,
    required this.entries,
  });

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return const Card(
        child: ListTile(
          leading: Icon(Icons.history),
          title: Text("Noch keine Kontrollen"),
          subtitle: Text(
            "Für diese Maschine wurden noch keine Kontrollen gespeichert.",
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
            leading: const CircleAvatar(
              backgroundColor: Colors.indigo,
              child: Icon(
                Icons.fact_check,
                color: Colors.white,
              ),
            ),
            title: Text(
              DateFormat(
                'dd.MM.yyyy • HH:mm',
              ).format(entry.dateTime),
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
                      "Hydrauliköl: ${entry.hydraulicOil.toStringAsFixed(1)} L"),
                  Text(
                      "Gleitbahnöl: ${entry.guidewayOil.toStringAsFixed(1)} L"),
                  Text(
                      "Wasserzähler: ${entry.waterMeter.toStringAsFixed(0)}"),
                  Text(
                      "Konzentration: ${entry.concentration.toStringAsFixed(1)} %"),
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