import 'package:equatable/equatable.dart';
import 'package:restaurent_app/model/cart_model.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> items;

  const CartLoaded(this.items);

  @override
  List<Object> get props => [items];
}

class CartOperationFailure extends CartState {}
