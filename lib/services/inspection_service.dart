import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/inspection_entry.dart';

class InspectionService {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<void> insertInspection(
    InspectionEntry entry,
  ) async {
    final db = await _databaseHelper.database;

    await db.insert(
      'inspection_entries',
      entry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<InspectionEntry>> getAllInspections() async {
    final db = await _databaseHelper.database;

    final maps = await db.query(
      'inspection_entries',
      orderBy: 'dateTime DESC',
    );

    return maps
        .map((e) => InspectionEntry.fromMap(e))
        .toList();
  }

  Future<List<InspectionEntry>> getMachineInspections(
    String machineId,
  ) async {
    final db = await _databaseHelper.database;

    final maps = await db.query(
      'inspection_entries',
      where: 'machineId = ?',
      whereArgs: [machineId],
      orderBy: 'dateTime DESC',
    );

    return maps
        .map((e) => InspectionEntry.fromMap(e))
        .toList();
  }

  Future<void> deleteInspection(int id) async {
    final db = await _databaseHelper.database;

    await db.delete(
      'inspection_entries',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}