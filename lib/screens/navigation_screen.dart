import 'package:flutter/material.dart';
import 'oil_stock_screen.dart';
import 'dashboard_screen.dart';
import 'history_screen.dart';
import 'machine_screen.dart';
import 'qr_scanner_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
  const DashboardScreen(),
  const MachineScreen(),
  const QrScannerScreen(),
  const HistoryScreen(),
  OilStockScreen(),
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
            icon: Icon(Icons.history),
            label: "Historie",
          ),
          BottomNavigationBarItem(
             icon: Icon(Icons.inventory_2),
             label: "Lager",
          ),
        ],
      ),
    );
  }
}