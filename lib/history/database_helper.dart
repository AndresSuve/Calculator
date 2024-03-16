import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'calculator_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE calculations(id INTEGER PRIMARY KEY AUTOINCREMENT, calculation TEXT, timestamp TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertCalculation(String calculation, String timestamp) async {
    final Database db = await database;
    await db.insert(
      'calculations',
      {'calculation': calculation, 'timestamp': timestamp},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getCalculations() async {
    final Database db = await database;
    return db.query('calculations');
  }
}
