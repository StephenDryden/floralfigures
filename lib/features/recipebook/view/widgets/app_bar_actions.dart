import 'package:flutter/material.dart';

class AppBarActions {
  static List<Widget> build({
    required String? recipeId,
    required VoidCallback onDelete,
    required VoidCallback onSave,
    required VoidCallback onAdd,
  }) {
    return [
      if (recipeId != null)
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: onDelete,
        ),
      IconButton(
        icon: Icon(Icons.save),
        onPressed: onSave,
      ),
      IconButton(
        icon: Icon(Icons.add),
        onPressed: onAdd,
      ),
    ];
  }
}
