import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final DatabaseProvider _instance = DatabaseProvider._internal();
  factory DatabaseProvider() => _instance;
  DatabaseProvider._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = p.join(databasePath, 'restaurant.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE tables(id INTEGER PRIMARY KEY, name TEXT, numberOfSeats INTEGER, tableStatus INTEGER, time TEXT)",
        );
        await db.execute(
          "CREATE TABLE categories(id INTEGER PRIMARY KEY, name TEXT)",
        );
        await db.execute(
          "CREATE TABLE products(id INTEGER PRIMARY KEY, name TEXT, price INTEGER, category_id INTEGER)",
        );
        await db.execute(
          "CREATE TABLE cart(id INTEGER PRIMARY KEY, cart_id INTEGER, table_id INTEGER, product_id INTEGER, name TEXT, price INTEGER, quantity INTEGER)",
        );
        await db.execute(
          "CREATE TABLE orders(id INTEGER PRIMARY KEY, cart_id INTEGER, table_id INTEGER, order_date TEXT, total_amount INTEGER)",
        );
      },
      onOpen: (db) {
        db.execute('PRAGMA foreign_keys = OFF');
      },
    );
  }
}
