import 'package:equatable/equatable.dart';
import 'package:restaurent_app/model/order_model.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class PlaceOrder extends OrderEvent {
  final Order order;

  const PlaceOrder(this.order);

  @override
  List<Object> get props => [order];
}

class LoadOrders extends OrderEvent {
  final int cartId;

  const LoadOrders(this.cartId);

  @override
  List<Object> get props => [cartId];
}

class LoadAllOrders extends OrderEvent {}
