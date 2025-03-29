import 'package:floralfigures/features/shoppingtrip/viewmodel/shopping_trip_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../utils/menu_drawer.dart';
import 'package:floralfigures/utils/app_bar.dart';

import 'add_shopping_trip_page.dart';

class ShoppingTripPage extends StatelessWidget {
  const ShoppingTripPage({super.key});

  void _navigateToAddShoppingTripPage(BuildContext context, {int? index}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddShoppingTripPage(shoppingTripIndex: index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, () => _navigateToAddShoppingTripPage(context),
          'Shopping Trips'),
      body: Consumer<ShoppingTripViewModel>(
        builder: (context, viewModel, child) {
          return ListView.builder(
            itemCount: viewModel.shoppingTrips.length,
            itemBuilder: (context, index) {
              final shoppingTrip = viewModel.shoppingTrips[index];
              return ListTile(
                title: Text(
                  shoppingTrip.name,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _navigateToAddShoppingTripPage(context, index: index);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        viewModel.deleteShoppingTrip(index);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      drawer: menuDrawer(context),
    );
  }
}
