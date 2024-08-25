import 'package:restaurent_app/model/category_model.dart';
import 'package:restaurent_app/model/product_model.dart';
import 'package:sqflite/sqflite.dart';

import '../database/database.dart';

class CategoryRepository {
  final DatabaseProvider _databaseProvider = DatabaseProvider();

  Future<List<Category>> fetchAllCategories() async {
    print("###################");

    final db = await _databaseProvider.database;
    print("###########2########");
    final categoryMaps = await db.query('categories');
    print("###########3########");
    final categories = <Category>[];

    for (var categoryMap in categoryMaps) {
      final products = await db.query(
        'products',
        where: 'category_id = ?',
        whereArgs: [categoryMap['id']],
      );

      categories.add(Category.fromMap(
          categoryMap, products.map((e) => Product.fromMap(e)).toList()));
    }

    return categories;
  }

  Future<void> bulkInsertCategories(List<Category> categories) async {
    final db = await _databaseProvider.database;

    await db.transaction((txn) async {
      for (var category in categories) {
        await txn.insert('categories', category.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace);

        for (var product in category.productList) {
          await txn.insert('products', product.toMap(),
              conflictAlgorithm: ConflictAlgorithm.replace);
        }
      }
    });
  }

  Future<List<Product>> fetchProductsByCategory(int categoryId) async {
    final db = await _databaseProvider.database;
    final productMaps = await db.query(
      'products',
      where: 'category_id = ?',
      whereArgs: [categoryId],
    );
    return productMaps
        .map((productMap) => Product.fromMap(productMap))
        .toList();
  }
}
