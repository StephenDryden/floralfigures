import 'package:flutter/material.dart';

Drawer menuDrawer(context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              'Floral Figures',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Builder(
          builder: (BuildContext context) {
            return Column(
              children: [
                ListTile(
                  title: const Text('Flower Market'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/flower_market');
                  },
                ),
                ListTile(
                  title: const Text('Recipe Book'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/recipe_book');
                  },
                ),
                ListTile(
                  title: const Text('Shopping Trip'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/shopping_trip');
                  },
                ),
              ],
            );
          },
        ),
      ],
    ),
  );
}


                        // onTap: () {
                        //   Navigator.pop(context);
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => ShoppingTripPage()));
                        // },