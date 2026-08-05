import 'dart:io';
import 'package:flutter/material.dart';
import '../models/machine.dart';
import '../services/machine_service.dart';
import '../models/inspection_entry.dart';
import '../services/inspection_service.dart';
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
  final InspectionService _inspectionService = InspectionService();

  late Machine machine;

  List<InspectionEntry> history = [];

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

    history = await _inspectionService.getMachineInspections(machine.id);

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
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Betriebsstoffe",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

const SizedBox(height: 20),

Card(
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Maschineninformationen",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        ListTile(
          leading: const Icon(Icons.qr_code),
          title: const Text("QR-Code"),
          trailing: Text(machine.qrCode),
        ),

        ListTile(
          leading: const Icon(Icons.badge),
          title: const Text("Maschinen-ID"),
          trailing: Text(machine.id),
        ),

        ListTile(
          leading: const Icon(Icons.description),
          title: const Text("Notizen"),
          subtitle: Text(
            machine.notes.isEmpty
                ? "Keine Notizen vorhanden"
                : machine.notes,
          ),
        ),
      ],
    ),
  ),
),

        const SizedBox(height: 12),

        ListTile(
          leading: const Icon(Icons.oil_barrel),
          title: const Text("Hydrauliköl"),
          trailing: Text(machine.hydraulicOil),
        ),

        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text("Gleitbahnöl"),
          trailing: Text(machine.guidewayOil),
        ),

        ListTile(
          leading: const Icon(Icons.water_drop),
          title: const Text("Kühlschmierstoff"),
          trailing: Text(machine.coolant),
        ),
      ],
    ),
  ),
),

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

          Card(
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Tankdaten",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        ListTile(
          leading: const Icon(Icons.oil_barrel),
          title: const Text("Hydrauliktank"),
          trailing: Text("${machine.hydraulicTank} L"),
        ),

        ListTile(
          leading: const Icon(Icons.water_drop),
          title: const Text("KSS-Tank"),
          trailing: Text("${machine.coolantTank} L"),
        ),
      ],
    ),
  ),
),

        

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

const SizedBox(height: 20),

Card(
  color: Colors.indigo.shade50,
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Row(
      children: [
        const Icon(
          Icons.analytics,
          color: Colors.indigo,
          size: 36,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Kontrollen",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${history.length} Einträge vorhanden",
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ],
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