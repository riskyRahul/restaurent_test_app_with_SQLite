import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurent_app/blocs/cart/cart_event.dart';
import 'package:restaurent_app/blocs/cart/cart_state.dart';
import 'package:restaurent_app/repository/cart_repository.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;

  CartBloc({required this.cartRepository}) : super(CartInitial()) {
    on<LoadCart>((event, emit) async {
      emit(CartLoading());
      try {
        final items = await cartRepository.fetchCartItems(event.cartId);
        emit(CartLoaded(items));
      } catch (_) {
        emit(CartOperationFailure());
      }
    });

    on<AddToCart>((event, emit) async {
      try {
        await cartRepository.addToCart(event.item);
        add(LoadCart(event.item.cartId));
      } catch (_) {
        emit(CartOperationFailure());
      }
    });

    on<RemoveFromCart>((event, emit) async {
      try {
        await cartRepository.removeFromCart(event.id);
        add(LoadCart(event.cartId));
      } catch (_) {
        emit(CartOperationFailure());
      }
    });

    on<ClearCart>((event, emit) async {
      try {
        await cartRepository.clearCart(event.cartId);
        add(LoadCart(event.cartId));
      } catch (_) {
        emit(CartOperationFailure());
      }
    });
  }
}
