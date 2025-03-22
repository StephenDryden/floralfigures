import 'package:floralfigures/utils/app_bar.dart';
import 'package:floralfigures/utils/menu_drawer.dart';
import 'package:flutter/material.dart';

class ShoppingTripPage extends StatelessWidget {
  const ShoppingTripPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, null, "Shopping Trip"),
      body: Center(
        child: Text(
          'Shopping Trip',
          style: TextStyle(fontSize: 24),
        ),
      ),
      drawer: menuDrawer(context),
    );
  }
}
