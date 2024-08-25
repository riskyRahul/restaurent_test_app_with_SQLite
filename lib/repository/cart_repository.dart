
import 'package:restaurent_app/database/database.dart';
import 'package:restaurent_app/model/cart_model.dart';
import 'package:sqflite/sqflite.dart';

class CartRepository {
  final DatabaseProvider _databaseProvider = DatabaseProvider();

  Future<List<CartItem>> fetchCartItems(int cartId) async {
    final db = await _databaseProvider.database;
    final cartMaps = await db.query(
      'cart',
      where: 'cart_id = ?',
      whereArgs: [cartId],
    );
    return cartMaps.map((map) => CartItem.fromMap(map)).toList();
  }

  Future<void> addToCart(CartItem item) async {
    final db = await _databaseProvider.database;
    await db.insert('cart', item.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removeFromCart(int id) async {
    final db = await _databaseProvider.database;
    await db.delete('cart', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearCart(int cartId) async {
    final db = await _databaseProvider.database;
    await db.delete('cart', where: 'cart_id = ?', whereArgs: [cartId]);
  }
}
