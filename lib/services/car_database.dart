import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/car_model.dart';

class CarDatabase {
  static final CarDatabase instance = CarDatabase._init();
  static Database? _database;

  CarDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('cars.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cars (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        brand TEXT,
        year TEXT,
        imageUrl TEXT
      )
    ''');
  }

  Future<void> insertCar(Car car) async {
    final db = await instance.database;
    await db.insert('cars', car.toMap());
  }

  Future<List<Car>> getCars() async {
    final db = await instance.database;
    final result = await db.query('cars');
    return result.map((map) => Car.fromMap(map)).toList();
  }
}
