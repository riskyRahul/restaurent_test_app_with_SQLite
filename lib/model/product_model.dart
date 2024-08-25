class Product {
  int id;
  String name;
  int price;
  int categoryId;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.categoryId,
  });

  // Convert a Product into a Map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'category_id': categoryId,
    };
  }

  // Extract a Product object from a Map.
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      categoryId: map['category_id'],
    );
  }
}
