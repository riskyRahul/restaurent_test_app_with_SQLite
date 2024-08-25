import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurent_app/blocs/cart/cart_bloc.dart';
import 'package:restaurent_app/blocs/cart/cart_event.dart';
import 'package:restaurent_app/blocs/menu_bloc/category/category_bloc.dart';
import 'package:restaurent_app/blocs/menu_bloc/category/category_event.dart';
import 'package:restaurent_app/blocs/order/order_bloc.dart';
import 'package:restaurent_app/blocs/table_bloc/table_bloc.dart';
import 'package:restaurent_app/blocs/table_bloc/table_event.dart';
import 'package:restaurent_app/repository/cart_repository.dart';
import 'package:restaurent_app/repository/category_repository.dart';
import 'package:restaurent_app/repository/order_repository.dart';
import 'package:restaurent_app/repository/table_repository.dart';
import 'package:restaurent_app/ui/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TableBloc>(
          create: (context) =>
              TableBloc(tableRepository: TableRepository())..add(LoadTables()),
        ),
        BlocProvider<CategoryBloc>(
          create: (context) =>
              CategoryBloc(categoryRepository: CategoryRepository())
                ..add(LoadCategories()),
        ),
        BlocProvider<CartBloc>(
          create: (context) =>
              CartBloc(cartRepository: CartRepository()),
        ),
        BlocProvider<OrderBloc>(
          create: (context) =>
              OrderBloc(orderRepository: OrderRepository()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Tables'),
      ),
    );
  }
}
