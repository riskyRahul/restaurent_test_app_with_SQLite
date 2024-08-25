import 'package:restaurent_app/model/product_model.dart';

import '../database/database.dart';

class ProductRepository {
  final DatabaseProvider _databaseProvider = DatabaseProvider();

  Future<List<Product>> fetchAllProducts() async {
    final db = await _databaseProvider.database;
    final productMaps = await db.query('products');

    return productMaps.map((e) => Product.fromMap(e)).toList();
  }
}
