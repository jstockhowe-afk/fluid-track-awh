import 'package:flutter/material.dart';
import '../services/inspection_service.dart';
import '../theme/app_colors.dart';
import '../widgets/fluid_card.dart';
import '../data/machine_data.dart';
import 'qr_scanner_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final InspectionService _service = InspectionService();

  int inspectionsToday = 0;
  double hydraulicToday = 0;
  int totalMachines = machines.length;

  @override
  void initState() {
    super.initState();
    _loadDashboard();
  }

  Future<void> _loadDashboard() async {
    final entries = await _service.getAllInspections();

    final now = DateTime.now();

    int count = 0;
    double liters = 0;

    for (final entry in entries) {
      if (entry.dateTime.year == now.year &&
          entry.dateTime.month == now.month &&
          entry.dateTime.day == now.day) {
        count++;
        liters += entry.hydraulicOil;
      }
    }

    if (!mounted) return;

    setState(() {
  inspectionsToday = count;
  hydraulicToday = liters;
});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
  DateTime.now().hour < 12
      ? "Guten Morgen"
      : DateTime.now().hour < 18
          ? "Guten Tag"
          : "Guten Abend",
            style: TextStyle(
              fontSize: 18,
            ),
          ),

          const SizedBox(height: 4),

          const Text(
            "Julian",
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 24),

          Row(
            children: [
              Expanded(
                child: FluidCard(
                  child: Column(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 38,
                      ),
                      SizedBox(height: 12),
                      Text(
                         inspectionsToday.toString(),
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("kontrolliert"),
                      const SizedBox(height: 8),

Text(
  "${hydraulicToday.toStringAsFixed(1)} L",
  style: const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  ),
),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: FluidCard(
                  child: Column(
                    children: [
                      Icon(
                        Icons.schedule,
                        color: Colors.orange,
                        size: 38,
                      ),
                      SizedBox(height: 12),
                     Text(
  (totalMachines - inspectionsToday)
      .clamp(0, totalMachines)
      .toString(),
  style: const TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.bold,
  ),
),

Text(
  "$totalMachines Maschinen",
),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          const Text(
            "Lagerbestand",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          FluidCard(
            child: Column(
              children: [
                _oilRow("HLP32", "420 l", Colors.blue),
                Divider(),
                _oilRow("HLP46", "820 l", Colors.blue),
                Divider(),
                _oilRow("XG68", "95 l", Colors.orange),
                Divider(),
                _oilRow("HLP22", "80 l", Colors.grey),
              ],
            ),
          ),

          const SizedBox(height: 24),

          SizedBox(
            height: 60,
            child: ElevatedButton.icon(
             onPressed: () async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const QrScannerScreen(),
    ),
  );

  if (!mounted) return;

  _loadDashboard();
},
              icon: const Icon(Icons.qr_code_scanner),
              label: const Text(
                "QR-Code scannen",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _oilRow(
    String oil,
    String amount,
    Color color,
  ) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: const Icon(
          Icons.opacity,
          color: Colors.white,
        ),
      ),
      title: Text(
        oil,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Text(
        amount,
        style: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}