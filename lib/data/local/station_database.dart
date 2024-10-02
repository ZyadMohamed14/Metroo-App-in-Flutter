import 'package:metroappinflutter/domain/model/station.dart';
import 'package:metroappinflutter/data/local/station_entity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class StationDatabaseHelper {
  static final StationDatabaseHelper _instance = StationDatabaseHelper._internal();
  static Database? _database;

  StationDatabaseHelper._internal();

  factory StationDatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'station_database.db');

    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE stations(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            start TEXT,
            end TEXT,
            path TEXT,
            time REAL,
            noOfStations INTEGER,
            ticketPrice REAL,
            direction TEXT
          )
          ''',
        );
      },
      version: 1,
    );
  }

  Future<void> insertStation(Station station) async {
    final db = await database;
    await db.insert(
      'stations',
      station.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<StationEntity>> getStations() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('stations');

    return List.generate(maps.length, (i) {
      return StationEntity.fromMap(maps[i]);
    });
  }

  Future<void> deleteStation(int id) async {
    final db = await database;
    await db.delete(
      'stations',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateStation(Station station, int id) async {
    final db = await database;
    await db.update(
      'stations',
      station.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
