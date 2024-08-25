import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurent_app/blocs/table_bloc/table_bloc.dart';
import 'package:restaurent_app/blocs/table_bloc/table_event.dart';
import 'package:restaurent_app/blocs/table_bloc/table_state.dart';
import 'package:restaurent_app/ui/create_order_page.dart';
import 'package:restaurent_app/model/table_model.dart';
import 'package:restaurent_app/ui/order_list.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: const Text(
                'Restaurant App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Order List'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  OrderPage()),
                );
              },
            ),
            // Add more ListTiles for other drawer items if needed
          ],
        ),
      ),
      body: BlocBuilder<TableBloc, TableState>(
        builder: (context, state) {
          if (state is TableLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TableLoaded) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: state.tables.length,
              itemBuilder: (BuildContext context, int index) {
                final table = state.tables[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateOrderPage(table: table),
                        ));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          table.name,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: const BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "0/${table.numberOfSeats}",
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('Failed to fetch tables'));
          }
        },
      ),
    );
  }
}

// return ListView.builder(
//               itemCount: state.tables.length,
//               itemBuilder: (context, index) {
//                 final table = state.tables[index];
//                 return ListTile(
//                   title: Text(table.name),
//                   subtitle: Text(
//                       'Seats: ${table.numberOfSeats}, Status: ${table.tableStatus}'),
//                   trailing: IconButton(
//                     icon: Icon(Icons.delete),
//                     onPressed: () {
//                       context.read<TableBloc>().add(DeleteTable(table.id!));
//                     },
//                   ),
//                   onTap: () {
//                     // Handle update or details
//                   },
//                 );
//               },
//             );
