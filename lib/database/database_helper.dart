import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('fluid_track_awh.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE machines(
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        costCenter TEXT NOT NULL,
        imagePath TEXT,
        hydraulicOil TEXT,
        guidewayOil TEXT,
        coolant TEXT,
        hydraulicTank INTEGER,
        coolantTank INTEGER,
        qrCode TEXT,
        notes TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE oil_entries(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        machineId TEXT NOT NULL,
        medium TEXT NOT NULL,
        liters REAL NOT NULL,
        comment TEXT,
        dateTime TEXT NOT NULL
      )
    ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}