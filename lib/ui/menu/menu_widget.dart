import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurent_app/blocs/cart/cart_bloc.dart';
import 'package:restaurent_app/blocs/cart/cart_event.dart';
import 'package:restaurent_app/blocs/cart/cart_state.dart';
import 'package:restaurent_app/blocs/menu_bloc/category/category_bloc.dart';
import 'package:restaurent_app/blocs/menu_bloc/category/category_event.dart';
import 'package:restaurent_app/model/cart_model.dart';
import 'package:restaurent_app/model/table_model.dart';

class MenuWidget extends StatefulWidget {
  final MTable table;
  const MenuWidget({super.key, required this.table});

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  String? selectedMenuItem;
  int? currentCartId;
  Future<void> _checkOrCreateCart() async {
    // Check if there's an existing cart for the table
    context.read<CartBloc>().add(LoadCart(widget.table.id!));
  }

  @override
  void initState() {
    _checkOrCreateCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if (state is CartLoaded) {
          if (state.items.isNotEmpty) {
            // Assign the current cart ID based on the first item in the cart
            currentCartId = state.items.first.cartId;
          } else {
            // If the cart is empty, create a new cart
            // context.read<CartBloc>().add(CreateCart(widget.table.id!));
            currentCartId = DateTime.now().millisecondsSinceEpoch;
          }
        }
      },
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoryLoaded) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      selectedMenuItem != null
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedMenuItem = null;
                                });
                              },
                              child: const Icon(Icons.arrow_back),
                            )
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedMenuItem = null;
                                });
                              },
                              child: const Icon(Icons.menu)),
                      const SizedBox(width: 8),
                      Text(
                        selectedMenuItem ?? "Menu",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                if (selectedMenuItem == null)
                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3,
                      ),
                      itemCount: state.categories.length,
                      itemBuilder: (BuildContext context, int index) {
                        final category = state.categories[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedMenuItem = category.name;
                            });
                            context.read<CategoryBloc>().add(
                                  LoadCategoryProducts(category.id),
                                );
                          },
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.grey,
                              ),
                            ),
                            child: Center(
                              child: Text(category.name),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                else
                  Expanded(
                    child: BlocBuilder<CategoryBloc, CategoryState>(
                      builder: (context, state) {
                        if (state is CategoryLoaded) {
                          final categoryId = state.categories
                              .firstWhere((cat) => cat.name == selectedMenuItem)
                              .id;
                          final products =
                              state.categoryProducts[categoryId] ?? [];
                          return GridView.builder(
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 3,
                            ),
                            itemCount: products.length,
                            itemBuilder: (BuildContext context, int index) {
                              final product = products[index];
                              return GestureDetector(
                                onTap: () {
                                  // to do add to cart
                                  // Add to cart functionality
                                  final cartItem = CartItem(
                                    id: DateTime.now().millisecondsSinceEpoch,
                                    name: product.name,
                                    price: product.price,
                                    cartId: currentCartId!,
                                    tableId: widget.table.id!,
                                    productId: product.id,
                                    quantity:
                                        1, // Default quantity for each item added to cart
                                  );
                                  context
                                      .read<CartBloc>()
                                      .add(AddToCart(cartItem));
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Icon(Icons.fastfood),
                                        Text(product.name),
                                        Text("${product.price}\$",
                                            style: TextStyle(
                                                color: Colors.greenAccent)),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                        return Center(child: Text('No products available'));
                      },
                    ),
                  ),
              ],
            );
          } else {
            return Center(child: Text('Failed to load data'));
          }
        },
      ),
    );
  }
}
