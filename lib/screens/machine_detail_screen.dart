import 'dart:io';
import 'package:flutter/material.dart';
import '../models/machine.dart';
import '../services/machine_service.dart';
import '../models/oil_entry.dart';
import '../services/oil_entry_service.dart';
import '../widgets/oil_history_list.dart';
import 'edit_machine_screen.dart';
import 'inspection_screen.dart';

class MachineDetailScreen extends StatefulWidget {
  final Machine machine;

  const MachineDetailScreen({
    super.key,
    required this.machine,
  });

  @override
  State<MachineDetailScreen> createState() => _MachineDetailScreenState();
}

class _MachineDetailScreenState extends State<MachineDetailScreen> {
  final MachineService _machineService = MachineService();
  final OilEntryService _oilEntryService = OilEntryService();

  late Machine machine;

  List<OilEntry> history = [];

  @override
  void initState() {
    super.initState();
    machine = widget.machine;
    _reloadMachine();
  }

  Future<void> _reloadMachine() async {
    final updated = await _machineService.getMachineById(machine.id);

    if (updated != null) {
      machine = updated;
    }

    history = await _oilEntryService.getEntriesForMachine(machine.id);

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _editMachine() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditMachineScreen(
          machine: machine,
        ),
      ),
    );

    if (result == true) {
      await _reloadMachine();
    }
  }

  Future<void> _openOilEntry() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
      builder: (_) => InspectionScreen(
      machine: machine,
),
      ),
    );

    await _reloadMachine();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(machine.name),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: machine.imagePath.isEmpty
                ? Container(
                    height: 220,
                    color: Colors.grey.shade300,
                    child: const Center(
                      child: Icon(
                        Icons.image,
                        size: 80,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : Image.file(
                    File(machine.imagePath),
                    height: 220,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),

          const SizedBox(height: 20),

          Card(
            child: ListTile(
              leading: const Icon(Icons.precision_manufacturing),
              title: const Text("Maschine"),
              subtitle: Text(machine.name),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.numbers),
              title: const Text("Kostenstelle"),
              subtitle: Text(machine.costCenter),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.oil_barrel),
              title: const Text("Hydrauliköl"),
              subtitle: Text(
                machine.hydraulicOil.isEmpty
                    ? "Nicht festgelegt"
                    : machine.hydraulicOil,
              ),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.opacity),
              title: const Text("Gleitbahnöl"),
              subtitle: Text(
                machine.guidewayOil.isEmpty
                    ? "Nicht festgelegt"
                    : machine.guidewayOil,
              ),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.water_drop),
              title: const Text("Kühlschmierstoff"),
              subtitle: Text(
                machine.coolant.isEmpty
                    ? "Nicht festgelegt"
                    : machine.coolant,
              ),
            ),
          ),

          const SizedBox(height: 30),

          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Historie",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 10),

          OilHistoryList(
            entries: history,
          ),

          const SizedBox(height: 25),

          SizedBox(
            height: 55,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.oil_barrel),
              label: const Text("Öl nachfüllen"),
              onPressed: _openOilEntry,
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            height: 55,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.edit),
              label: const Text("Maschine bearbeiten"),
              onPressed: _editMachine,
            ),
          ),
        ],
      ),
    );
  }
}