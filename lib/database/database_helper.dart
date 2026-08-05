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

    return openDatabase(
      path,
      version: 4,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
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
        notes TEXT,
        coolantConcentration REAL DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE inspection_entries(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        machineId TEXT NOT NULL,
        hydraulicOil REAL NOT NULL,
        guidewayOil REAL NOT NULL,
        waterMeter REAL NOT NULL,
        concentration REAL NOT NULL,
        comment TEXT,
        dateTime TEXT NOT NULL
      )
    ''');
    await db.execute('''
  CREATE TABLE oil_stock(
    name TEXT PRIMARY KEY,
    amount REAL NOT NULL,
    minimumAmount REAL NOT NULL
  )
''');

await db.insert('oil_stock', {
  'name': 'HLP22',
  'amount': 80.0,
  'minimumAmount': 20.0,
});

await db.insert('oil_stock', {
  'name': 'HLP32',
  'amount': 420.0,
  'minimumAmount': 100.0,
});

await db.insert('oil_stock', {
  'name': 'HLP46',
  'amount': 820.0,
  'minimumAmount': 150.0,
});

await db.insert('oil_stock', {
  'name': 'XG68',
  'amount': 95.0,
  'minimumAmount': 20.0,
});

await db.insert('oil_stock', {
  'name': 'Kühlschmierstoff',
  'amount': 350.0,
  'minimumAmount': 80.0,
});
  }

  Future<void> _upgradeDB(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    if (oldVersion < 3) {
      await db.execute('DROP TABLE IF EXISTS oil_entries');
      if (oldVersion < 4) {
  await db.execute('''
    CREATE TABLE oil_stock(
      name TEXT PRIMARY KEY,
      amount REAL NOT NULL,
      minimumAmount REAL NOT NULL
    )
  ''');

  await db.insert('oil_stock', {
    'name': 'HLP22',
    'amount': 80.0,
    'minimumAmount': 20.0,
  });

  await db.insert('oil_stock', {
    'name': 'HLP32',
    'amount': 420.0,
    'minimumAmount': 100.0,
  });

  await db.insert('oil_stock', {
    'name': 'HLP46',
    'amount': 820.0,
    'minimumAmount': 150.0,
  });

  await db.insert('oil_stock', {
    'name': 'XG68',
    'amount': 95.0,
    'minimumAmount': 20.0,
  });

  await db.insert('oil_stock', {
    'name': 'Kühlschmierstoff',
    'amount': 350.0,
    'minimumAmount': 80.0,
  });
}

      await db.execute('''
        CREATE TABLE inspection_entries(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          machineId TEXT NOT NULL,
          hydraulicOil REAL NOT NULL,
          guidewayOil REAL NOT NULL,
          waterMeter REAL NOT NULL,
          concentration REAL NOT NULL,
          comment TEXT,
          dateTime TEXT NOT NULL
        )
      ''');

      try {
        await db.execute(
          'ALTER TABLE machines ADD COLUMN coolantConcentration REAL DEFAULT 0',
        );
      } catch (_) {}
    }
  }

  Future<void> close() async {
    final db = await instance.database;
    await db.close();
  }
}