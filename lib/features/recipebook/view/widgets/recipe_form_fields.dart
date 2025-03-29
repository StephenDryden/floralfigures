import 'package:flutter/material.dart';

class RecipeFormFields extends StatelessWidget {
  final TextEditingController nameController;
  final ValueChanged<String>? onNameChanged;

  const RecipeFormFields({
    super.key,
    required this.nameController,
    this.onNameChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: nameController,
        decoration: InputDecoration(
          labelText: 'Recipe Name',
          border: OutlineInputBorder(),
        ),
        onChanged: onNameChanged,
      ),
    );
  }
}
