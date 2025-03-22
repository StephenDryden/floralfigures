import 'package:floralfigures/utils/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:floralfigures/utils/menu_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, null, "Floral Figures"),
      body: Center(
        child: Text(
          'Welcome to Floral Figures. Use the menu to navigate between the Flower Market, Recipe Book and Shopping List.',
          textAlign: TextAlign.center,
        ),
      ),
      drawer: menuDrawer(context),
    );
  }
}
