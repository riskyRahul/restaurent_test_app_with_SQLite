import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurent_app/blocs/order/order_bloc.dart';
import 'package:restaurent_app/blocs/order/order_event.dart';
import 'package:restaurent_app/blocs/order/order_state.dart';
import 'package:restaurent_app/repository/order_repository.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: BlocProvider(
        create: (context) =>
            OrderBloc(orderRepository: OrderRepository())..add(LoadAllOrders()),
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrderLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is OrdersLoaded) {
              final orders = state.orders;
              if (orders.isEmpty) {
                return const Center(child: Text('No orders available.'));
              }
              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return ListTile(
                    title: Text('Order ID: #${order.id}'),
                    subtitle: Text(
                      'Total: \$${order.totalAmount}',
                      style: const TextStyle(color: Colors.greenAccent),
                    ),
                    trailing: Column(
                      children: [
                        Text(order.orderDate.split("T").first),
                        Text("time:-${order.orderDate.split("T").last.split(":")[0]}:${order.orderDate.split("T").last.split(":")[1]}"),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text('Failed to load orders.'));
            }
          },
        ),
      ),
    );
  }
}
