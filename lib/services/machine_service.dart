import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/machine.dart';

class MachineService {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  /// Alle Maschinen laden
  Future<List<Machine>> getMachines() async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'machines',
      orderBy: 'name ASC',
    );

    return maps.map((e) => Machine.fromMap(e)).toList();
  }

  /// Maschine über ID laden
  Future<Machine?> getMachineById(String id) async {
    final Database db = await _databaseHelper.database;

    final result = await db.query(
      'machines',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) return null;

    return Machine.fromMap(result.first);
  }

  /// Maschine über QR-Code laden
  Future<Machine?> getMachineByQrCode(String qrCode) async {
    final Database db = await _databaseHelper.database;

    final result = await db.query(
      'machines',
      where: 'qrCode = ?',
      whereArgs: [qrCode],
      limit: 1,
    );

    if (result.isEmpty) return null;

    return Machine.fromMap(result.first);
  }

  /// Neue Maschine speichern
  Future<void> insertMachine(Machine machine) async {
    final Database db = await _databaseHelper.database;

    await db.insert(
      'machines',
      machine.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Maschine aktualisieren
  Future<void> updateMachine(Machine machine) async {
    final Database db = await _databaseHelper.database;

    await db.update(
      'machines',
      machine.toMap(),
      where: 'id = ?',
      whereArgs: [machine.id],
    );
  }

  /// Maschine löschen
  Future<void> deleteMachine(String id) async {
    final Database db = await _databaseHelper.database;

    await db.delete(
      'machines',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Anzahl aller Maschinen
  Future<int> getMachineCount() async {
    final Database db = await _databaseHelper.database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM machines',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }
}