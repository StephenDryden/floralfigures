import 'package:flutter/material.dart';

AppBar appBar(context, createNewTask) {
  return AppBar(
    title: const Text(
      "Floral Figures",
    ),
    centerTitle: false,
    elevation: 1,
    actions: [
      IconButton(
        onPressed: createNewTask,
        icon: const Icon(Icons.add),
      )
    ],
    titleTextStyle: Theme.of(context).textTheme.displayLarge,
  );
}
