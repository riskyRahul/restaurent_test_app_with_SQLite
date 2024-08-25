class Order {
  final int id;
  final int cartId;
  final int tableId;
  final String orderDate;
  final int totalAmount;

  Order({
    required this.id,
    required this.cartId,
    required this.tableId,
    required this.orderDate,
    required this.totalAmount,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cart_id': cartId,
      'table_id': tableId,
      'order_date': orderDate,
      'total_amount': totalAmount,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      cartId: map['cart_id'],
      tableId: map['table_id'],
      orderDate: map['order_date'],
      totalAmount: map['total_amount'],
    );
  }
}
