import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:floralfigures/utils/my_button.dart';
import 'package:floralfigures/utils/quantity_input_field.dart';

import '../../../recipebook/model/recipe_model.dart';
import '../../../recipebook/viewmodel/recipe_viewmodel.dart';

class AddRecipeDialog extends StatefulWidget {
  final TextEditingController quantityController;
  final Recipe? selectedRecipe;
  final ValueChanged<Recipe?> onRecipeChanged;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const AddRecipeDialog({
    super.key,
    required this.quantityController,
    required this.selectedRecipe,
    required this.onRecipeChanged,
    required this.onSave,
    required this.onCancel,
  });

  @override
  AddRecipeDialogState createState() => AddRecipeDialogState();
}

class AddRecipeDialogState extends State<AddRecipeDialog> {
  Recipe? _selectedRecipe;

  @override
  void initState() {
    super.initState();
    _selectedRecipe = widget.selectedRecipe;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2))),
      content: SizedBox(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Consumer<RecipeViewModel>(
              builder: (context, recipeViewModel, child) {
                return DropdownButton<Recipe>(
                  hint: Text('Select Recipe'),
                  value: _selectedRecipe,
                  onChanged: (Recipe? newValue) {
                    setState(() {
                      _selectedRecipe = newValue;
                    });
                    widget.onRecipeChanged(newValue);
                  },
                  items: recipeViewModel.recipes
                      .map<DropdownMenuItem<Recipe>>((Recipe recipe) {
                    return DropdownMenuItem<Recipe>(
                      value: recipe,
                      child: Text(recipe.name),
                    );
                  }).toList(),
                );
              },
            ),
            const SizedBox(height: 5),
            QuantityInputField(
              hint: "Quantity",
              controller: widget.quantityController,
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyButton(
                  text: "Save",
                  onPressed: widget.onSave,
                ),
                const SizedBox(width: 8),
                MyButton(
                  text: "Cancel",
                  onPressed: widget.onCancel,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
