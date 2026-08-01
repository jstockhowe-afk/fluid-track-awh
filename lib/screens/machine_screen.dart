import 'package:flutter/material.dart';

import '../models/machine.dart';
import '../repositories/machine_repository.dart';
import '../widgets/machine_card.dart';
import 'machine_detail_screen.dart';

class MachineScreen extends StatefulWidget {
  const MachineScreen({super.key});

  @override
  State<MachineScreen> createState() => _MachineScreenState();
}

class _MachineScreenState extends State<MachineScreen> {
  final MachineRepository _machineRepository = MachineRepository();

  late Future<List<Machine>> _machinesFuture;

  @override
  void initState() {
    super.initState();
    _loadMachines();
  }

  void _loadMachines() {
  _machinesFuture = _machineRepository.getMachines();
  }

  Future<void> _refresh() async {
    setState(() {
      _loadMachines();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Maschinen"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Machine>>(
        future: _machinesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Fehler: ${snapshot.error}",
                textAlign: TextAlign.center,
              ),
            );
          }

          final machines = snapshot.data ?? [];

          if (machines.isEmpty) {
            return const Center(
              child: Text(
                "Keine Maschinen vorhanden.",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: machines.length,
              itemBuilder: (context, index) {
                final machine = machines[index];

                return MachineCard(
                  machine: machine,
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MachineDetailScreen(
                          machine: machine,
                        ),
                      ),
                    );

                    if (mounted) {
                      _refresh();
                    }
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}