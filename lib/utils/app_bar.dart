import 'package:flutter/material.dart';

AppBar appBar(BuildContext context, VoidCallback? createItem, String title) {
  return AppBar(
    title: Text(title),
    centerTitle: false,
    elevation: 1,
    actions: createItem != null
        ? [
            IconButton(
              onPressed: createItem,
              icon: const Icon(Icons.add),
            )
          ]
        : null,
    titleTextStyle: Theme.of(context).textTheme.displayLarge,
    leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        );
      },
    ),
  );
}
