import 'product_model.dart';

class Category {
  int id;
  String name;
  List<Product> productList;

  Category({
    required this.id,
    required this.name,
    this.productList = const [],
  });

  // Convert a Category into a Map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  // Extract a Category object from a Map.
  factory Category.fromMap(Map<String, dynamic> map, List<Product> products) {
    return Category(
      id: map['id'],
      name: map['name'],
      productList: products,
    );
  }
}
