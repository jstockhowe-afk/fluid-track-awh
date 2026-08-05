import 'package:flutter/material.dart';

import '../models/inspection_entry.dart';
import '../services/inspection_service.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final InspectionService _service = InspectionService();

  late Future<List<InspectionEntry>> _history;

  @override
  void initState() {
    super.initState();
    _history = _service.getAllInspections();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Historie"),
      ),
      body: FutureBuilder<List<InspectionEntry>>(
        future: _history,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          final entries = snapshot.data ?? [];

          if (entries.isEmpty) {
            return const Center(
              child: Text("Noch keine Kontrollen vorhanden."),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final entry = entries[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.fact_check),
                  ),
                  title: Text(entry.machineId),
                  subtitle: Text(
                    "Hydraulik: ${entry.hydraulicOil} L\n"
                    "Gleitbahn: ${entry.guidewayOil} L\n"
                    "Konzentration: ${entry.concentration} %",
                  ),
                  trailing: Text(
                    "${entry.dateTime.day}.${entry.dateTime.month}",
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}