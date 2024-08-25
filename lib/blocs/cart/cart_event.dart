import 'package:equatable/equatable.dart';
import 'package:restaurent_app/model/cart_model.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class LoadCart extends CartEvent {
   int cartId;

   LoadCart(this.cartId);

  @override
  List<Object> get props => [cartId];
}

class AddToCart extends CartEvent {
  final CartItem item;

  const AddToCart(this.item);

  @override
  List<Object> get props => [item];
}

class RemoveFromCart extends CartEvent {
  final int id;
  final int cartId; // Add cartId to this event if needed for reloading

  const RemoveFromCart(this.id, this.cartId);

  @override
  List<Object> get props => [id, cartId];
}

class ClearCart extends CartEvent {
  final int cartId;

  const ClearCart(this.cartId);

  @override
  List<Object> get props => [cartId];
}
