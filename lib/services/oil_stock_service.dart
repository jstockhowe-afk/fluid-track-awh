

import '../database/database_helper.dart';
import '../models/oil_stock.dart';

class OilStockService {
  final DatabaseHelper _databaseHelper =
      DatabaseHelper.instance;

  Future<List<OilStock>> getStocks() async {
    final db = await _databaseHelper.database;

    final maps = await db.query(
      'oil_stock',
      orderBy: 'name',
    );

    return maps
        .map((e) => OilStock(
              name: e['name'] as String,
              amount: (e['amount'] as num).toDouble(),
              minimum:
                  (e['minimumAmount'] as num).toDouble(),
            ))
        .toList();
  }

  Future<OilStock?> getStock(String name) async {
    final db = await _databaseHelper.database;

    final maps = await db.query(
      'oil_stock',
      where: 'name = ?',
      whereArgs: [name],
      limit: 1,
    );

    if (maps.isEmpty) return null;

    return OilStock(
      name: maps.first['name'] as String,
      amount: (maps.first['amount'] as num).toDouble(),
      minimum:
          (maps.first['minimumAmount'] as num).toDouble(),
    );
  }

  Future<void> removeOil(
    String name,
    double liters,
  ) async {
    final stock = await getStock(name);

    if (stock == null) return;

    final db = await _databaseHelper.database;

    await db.update(
      'oil_stock',
      {
        'amount':
            (stock.amount - liters).clamp(0.0, 999999.0),
      },
      where: 'name = ?',
      whereArgs: [name],
    );
  }
}