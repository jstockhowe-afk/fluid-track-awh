import 'package:flutter/material.dart';

import 'dashboard_screen.dart';
import 'machine_screen.dart';
import 'qr_scanner_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    DashboardScreen(),
    MachineScreen(),
    QrScannerScreen(),
    Center(
      child: Text(
        "Auswertungen\n\nfolgen in Version 0.4",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 22),
      ),
    ),
    Center(
      child: Text(
        "Einstellungen\n\nfolgen in Version 0.4",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 22),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_rounded),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.precision_manufacturing),
            label: "Maschinen",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: "Scanner",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Auswertung",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Einstellungen",
          ),
        ],
      ),
    );
  }
}