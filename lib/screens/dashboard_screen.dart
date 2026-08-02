import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/fluid_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Guten Morgen",
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
                    children: const [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 38,
                      ),
                      SizedBox(height: 12),
                      Text(
                        "5",
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("kontrolliert"),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: FluidCard(
                  child: Column(
                    children: const [
                      Icon(
                        Icons.schedule,
                        color: Colors.orange,
                        size: 38,
                      ),
                      SizedBox(height: 12),
                      Text(
                        "13",
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("offen"),
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
              onPressed: () {},
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