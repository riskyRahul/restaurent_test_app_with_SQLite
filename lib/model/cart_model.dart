class CartItem {
  final int id;
  final int cartId;
  final int tableId;
  final int productId;
  final String name;
  final int price;
  final int quantity;

  CartItem({
    required this.id,
    required this.cartId,
    required this.tableId,
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cart_id': cartId,
      'table_id': tableId,
      'product_id': productId,
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'],
      cartId: map['cart_id'],
      tableId: map['table_id'],
      productId: map['product_id'],
      name: map['name'],
      price: map['price'],
      quantity: map['quantity'],
    );
  }
}
