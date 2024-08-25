import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurent_app/blocs/cart/cart_bloc.dart';
import 'package:restaurent_app/blocs/cart/cart_event.dart';
import 'package:restaurent_app/blocs/cart/cart_state.dart';
import 'package:restaurent_app/blocs/order/order_bloc.dart';
import 'package:restaurent_app/blocs/order/order_event.dart';
import 'package:restaurent_app/blocs/order/order_state.dart';
import 'package:restaurent_app/model/cart_model.dart';
import 'package:restaurent_app/model/order_model.dart';
import 'package:restaurent_app/model/table_model.dart';

class CartWidget extends StatefulWidget {
  final MTable table;

  const CartWidget({super.key, required this.table});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CartLoaded) {
          final items = state.items;
          return Column(
            children: [
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      getTotal(items),
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    GestureDetector(
                      onTap: () {
                        int total = 0;
                        for (var element in items) {
                          total = total + element.price;
                        }
                        final order = Order(
                          tableId: widget.table.id!,
                          cartId: items.first.cartId,
                          id: DateTime.now().millisecondsSinceEpoch,
                          orderDate: DateTime.now().toIso8601String(),
                          totalAmount: total,
                        );
                        context.read<OrderBloc>().add(PlaceOrder(order));

                        // Listen for order placed state and clear the cart
                        context.read<OrderBloc>().stream.listen((state) {
                          if (state is OrderPlaced) {
                            context
                                .read<CartBloc>()
                                .add(ClearCart(widget.table.id!));
                          }
                        });
                        Navigator.pop(context);
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.save),
                          SizedBox(width: 8),
                          Text(
                            'Save Order',
                            style: TextStyle(
                                fontSize: 12), // Adjust the font size as needed
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              ListView.builder(
                itemCount: items.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text('Price: ${item.price}\$',
                        style: TextStyle(color: Colors.greenAccent)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        BlocProvider.of<CartBloc>(context)
                            .add(RemoveFromCart(item.id, item.cartId));
                      },
                    ),
                  );
                },
              ),
            ],
          );
        } else {
          return const Center(child: Text('Failed to load cart'));
        }
      },
    );
  }

  String getTotal(List<CartItem> lst) {
    int total = 0;
    for (var element in lst) {
      total = total + element.price;
    }
    return "Total: $total\$";
  }
}
