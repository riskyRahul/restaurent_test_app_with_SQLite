import 'package:restaurent_app/database/database.dart';
import 'package:restaurent_app/model/order_model.dart';
import 'package:sqflite/sqflite.dart';

class OrderRepository {
  final DatabaseProvider _databaseProvider = DatabaseProvider();

  Future<void> placeOrder(Order order) async {
    print("#########PlaceOrder#############");
    final db = await _databaseProvider.database;
    await db.insert('orders', order.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Order>> fetchOrders(int cartId) async {
    final db = await _databaseProvider.database;
    final orderMaps = await db.query(
      'orders',
      where: 'cart_id = ?',
      whereArgs: [cartId],
    );
    return orderMaps.map((map) => Order.fromMap(map)).toList();
  }

  Future<List<Order>> fetchAllOrders() async {
    final db = await _databaseProvider.database;
    final orderMaps = await db.query('orders');
    return orderMaps.map((map) => Order.fromMap(map)).toList();
  }
}
