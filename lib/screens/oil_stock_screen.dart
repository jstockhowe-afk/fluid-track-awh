import 'package:flutter/material.dart';

import '../models/oil_stock.dart';
import '../services/oil_stock_service.dart';

class OilStockScreen extends StatefulWidget {
  const OilStockScreen({super.key});

  @override
  State<OilStockScreen> createState() => _OilStockScreenState();
}

class _OilStockScreenState extends State<OilStockScreen> {
  final OilStockService service = OilStockService();

  late Future<List<OilStock>> _stocks;

  @override
  void initState() {
    super.initState();
    _stocks = service.getStocks();
  }

  Future<void> _refresh() async {
    setState(() {
      _stocks = service.getStocks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lagerbestand"),
      ),
      body: FutureBuilder<List<OilStock>>(
        future: _stocks,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          final stocks = snapshot.data ?? [];

          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: stocks.length,
              itemBuilder: (context, index) {
                final stock = stocks[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          stock.amount <= stock.minimum
                              ? Colors.red
                              : Colors.green,
                      child: const Icon(
                        Icons.oil_barrel,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      stock.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "Mindestbestand: ${stock.minimum.toStringAsFixed(0)} L",
                    ),
                    trailing: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      crossAxisAlignment:
                          CrossAxisAlignment.end,
                      children: [
                        Text(
                          "${stock.amount.toStringAsFixed(1)} L",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          stock.amount <= stock.minimum
                              ? "Nachbestellen"
                              : "OK",
                          style: TextStyle(
                            color:
                                stock.amount <= stock.minimum
                                    ? Colors.red
                                    : Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}