import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/oil_entry.dart';

class OilEntryService {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  /// Neue Buchung speichern
  Future<void> insertEntry(OilEntry entry) async {
    final Database db = await _databaseHelper.database;

    await db.insert(
      'oil_entries',
      entry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Alle Buchungen einer Maschine
  Future<List<OilEntry>> getEntriesForMachine(String machineId) async {
    final Database db = await _databaseHelper.database;

    final maps = await db.query(
      'oil_entries',
      where: 'machineId = ?',
      whereArgs: [machineId],
      orderBy: 'dateTime DESC',
    );

    return maps.map((e) => OilEntry.fromMap(e)).toList();
  }

  /// Alle Buchungen
  Future<List<OilEntry>> getAllEntries() async {
    final Database db = await _databaseHelper.database;

    final maps = await db.query(
      'oil_entries',
      orderBy: 'dateTime DESC',
    );

    return maps.map((e) => OilEntry.fromMap(e)).toList();
  }

  /// Letzte Buchung
  Future<OilEntry?> getLastEntry() async {
    final entries = await getAllEntries();

    if (entries.isEmpty) {
      return null;
    }

    return entries.first;
  }

  /// Verbrauch heute
  Future<double> getTodayConsumption() async {
    final entries = await getAllEntries();

    final now = DateTime.now();

    double total = 0;

    for (final entry in entries) {
      if (entry.dateTime.year == now.year &&
          entry.dateTime.month == now.month &&
          entry.dateTime.day == now.day) {
        total += entry.liters;
      }
    }

    return total;
  }

  /// Verbrauch im aktuellen Monat
  Future<double> getMonthConsumption() async {
    final entries = await getAllEntries();

    final now = DateTime.now();

    double total = 0;

    for (final entry in entries) {
      if (entry.dateTime.year == now.year &&
          entry.dateTime.month == now.month) {
        total += entry.liters;
      }
    }

    return total;
  }

  /// Anzahl aller Buchungen
  Future<int> getEntryCount() async {
    final Database db = await _databaseHelper.database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) FROM oil_entries',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  /// Buchung löschen
  Future<void> deleteEntry(int id) async {
    final Database db = await _databaseHelper.database;

    await db.delete(
      'oil_entries',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}