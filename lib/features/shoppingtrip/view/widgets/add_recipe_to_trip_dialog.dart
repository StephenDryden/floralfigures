import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:floralfigures/utils/my_button.dart';

import '../../../recipebook/model/recipe_model.dart';
import '../../../recipebook/viewmodel/recipe_viewmodel.dart';

class AddRecipeDialog extends StatelessWidget {
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
                  value: selectedRecipe,
                  onChanged: onRecipeChanged,
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
            InputField(
              hint: "Quantity",
              controller: quantityController,
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyButton(
                  text: "Save",
                  onPressed: onSave,
                ),
                const SizedBox(width: 8),
                MyButton(
                  text: "Cancel",
                  onPressed: onCancel,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.hint,
    required this.controller,
  });

  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Row(
        children: [
          Text(
            "$hint:",
            style: Theme.of(context).textTheme.labelLarge,
          ),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 10),
              ),
              controller: controller,
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }
}
