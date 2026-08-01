import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget buildCard(
      IconData icon,
      String title,
      String value,
      Color color,
      ) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 42, color: color),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f6fb),

      appBar: AppBar(
        title: const Text("Fluid Track AWH"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),

      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [

          SizedBox(
            height: 70,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              icon: const Icon(Icons.qr_code_scanner, size: 32),
              label: const Text(
                "QR-Code scannen",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              onPressed: () {},
            ),
          ),

          const SizedBox(height: 20),

          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 1.2,
            children: [

              buildCard(
                Icons.precision_manufacturing,
                "Maschinen",
                "18",
                Colors.indigo,
              ),

              buildCard(
                Icons.oil_barrel,
                "Ölsorten",
                "3",
                Colors.green,
              ),

              buildCard(
                Icons.warning_amber,
                "Warnungen",
                "0",
                Colors.orange,
              ),

              buildCard(
                Icons.bar_chart,
                "Verbrauch",
                "0 L",
                Colors.red,
              ),
            ],
          ),

          const SizedBox(height: 20),

          const Text(
            "Letzte Buchungen",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Card(
            child: ListTile(
              leading: const Icon(Icons.history),
              title: const Text("Noch keine Buchungen"),
              subtitle: const Text(
                "Die ersten Einträge erscheinen hier.",
              ),
            ),
          ),
        ],
      ),
    );
  }
}