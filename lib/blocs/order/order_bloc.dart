import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurent_app/blocs/order/order_event.dart';
import 'package:restaurent_app/blocs/order/order_state.dart';
import 'package:restaurent_app/repository/order_repository.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;

  OrderBloc({required this.orderRepository}) : super(OrderInitial()) {
    on<PlaceOrder>((event, emit) async {
      emit(OrderLoading());
      try {
        await orderRepository.placeOrder(event.order);
        emit(OrderPlaced());
      } catch (_) {
        emit(OrderOperationFailure());
      }
    });

    on<LoadOrders>((event, emit) async {
      emit(OrderLoading());
      try {
        final orders = await orderRepository.fetchOrders(event.cartId);
        emit(OrdersLoaded(orders));
      } catch (_) {
        emit(OrderOperationFailure());
      }
    });

    on<LoadAllOrders>((event, emit) async {
      emit(OrderLoading());
      try {
        final orders = await orderRepository.fetchAllOrders();
        emit(OrdersLoaded(orders));
      } catch (_) {
        emit(OrderOperationFailure());
      }
    });
  }
}
