import 'package:flutter/material.dart';
import 'package:restaurent_app/model/table_model.dart';
import 'package:restaurent_app/ui/menu/cart_widget.dart';
import 'package:restaurent_app/ui/menu/menu_widget.dart';

class CreateOrderPage extends StatefulWidget {
  final MTable table;
  const CreateOrderPage({super.key, required this.table});

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _showMenuBottomSheet();
  //   });
  // }

  // void _showMenuBottomSheet() {
  //   showModalBottomSheet(
  //     elevation: 0,
  //     showDragHandle: true,
  //     context: context,
  //     backgroundColor: Colors.transparent,
  //     builder: (context) {
  //       return MenuWidget();
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(flex: 6, child: CartWidget(table: widget.table,)),
          Expanded(flex: 4, child: MenuWidget(table: widget.table,))
        ],
      ),
    );
  }
}
