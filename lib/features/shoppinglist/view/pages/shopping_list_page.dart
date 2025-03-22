import 'package:floralfigures/utils/app_bar.dart';
import 'package:floralfigures/utils/menu_drawer.dart';
import 'package:flutter/material.dart';

class ShoppingListPage extends StatelessWidget {
  const ShoppingListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, null, "Shopping List"),
      body: Center(
        child: Text(
          'Shopping Listt',
          style: TextStyle(fontSize: 24),
        ),
      ),
      drawer: menuDrawer(context),
    );
  }
}
