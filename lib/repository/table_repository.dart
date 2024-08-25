import 'package:restaurent_app/database/database.dart';
import 'package:restaurent_app/model/table_model.dart';
import 'package:sqflite/sqflite.dart';

class TableRepository {
  final DatabaseProvider _databaseProvider = DatabaseProvider();

  Future<int> addTable(MTable table) async {
    final db = await _databaseProvider.database;
    return await db.insert('tables', table.toMap());
  }

  Future<List<MTable>> fetchAllTables() async {
    final db = await _databaseProvider.database;
    final maps = await db.query('tables');
    return List.generate(maps.length, (i) {
      return MTable.fromMap(maps[i]);
    });
  }

  Future<int> updateTable(MTable table) async {
    final db = await _databaseProvider.database;
    return await db.update(
      'tables',
      table.toMap(),
      where: 'id = ?',
      whereArgs: [table.id],
    );
  }

  Future<int> deleteTable(int id) async {
    final db = await _databaseProvider.database;
    return await db.delete(
      'tables',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> bulkInsertTables(List<MTable> tables) async {
    final db = await _databaseProvider.database;
    await db.transaction((txn) async {
      for (var table in tables) {
        await txn.insert(
          'tables',
          table.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }
}
