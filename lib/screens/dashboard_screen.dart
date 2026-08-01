import 'package:flutter/material.dart';

import '../services/machine_service.dart';
import '../services/oil_entry_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final MachineService _machineService = MachineService();
  final OilEntryService _oilEntryService = OilEntryService();

  int machineCount = 0;
  int bookingCount = 0;
  double litersToday = 0;
  double litersMonth = 0;

  @override
  void initState() {
    super.initState();
    _loadDashboard();
  }

  Future<void> _loadDashboard() async {
    final machines = await _machineService.getMachines();
    final entries = await _oilEntryService.getAllEntries();

    final now = DateTime.now();

    double today = 0;
    double month = 0;

    for (final entry in entries) {
      if (entry.dateTime.year == now.year &&
          entry.dateTime.month == now.month) {
        month += entry.liters;

        if (entry.dateTime.day == now.day) {
          today += entry.liters;
        }
      }
    }

    if (!mounted) return;

    setState(() {
      machineCount = machines.length;
      bookingCount = entries.length;
      litersToday = today;
      litersMonth = month;
    });
  }

  Widget buildCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Icon(
              icon,
              size: 38,
              color: color,
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(title),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fluid Track AWH"),
      ),
      body: RefreshIndicator(
        onRefresh: _loadDashboard,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              children: [
                Expanded(
                  child: buildCard(
                    "Maschinen",
                    "$machineCount",
                    Icons.precision_manufacturing,
                    Colors.blue,
                  ),
                ),
                Expanded(
                  child: buildCard(
                    "Buchungen",
                    "$bookingCount",
                    Icons.receipt_long,
                    Colors.green,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: buildCard(
                    "Heute",
                    "${litersToday.toStringAsFixed(1)} L",
                    Icons.today,
                    Colors.orange,
                  ),
                ),
                Expanded(
                  child: buildCard(
                    "Monat",
                    "${litersMonth.toStringAsFixed(1)} L",
                    Icons.calendar_month,
                    Colors.purple,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Card(
              child: ListTile(
                leading: Icon(Icons.info_outline),
                title: Text("Willkommen bei Fluid Track AWH"),
                subtitle: Text(
                  "Die Kennzahlen werden automatisch aus der Datenbank geladen.",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}