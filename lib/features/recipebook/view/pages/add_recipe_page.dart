import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/flower_list_item.dart';
import '../widgets/app_bar_actions.dart';
import '../../../flowermarket/model/flower_model.dart';
import '../widgets/add_flower_to_recipe_dialog.dart';
import '../../model/recipe_model.dart';
import '../../viewmodel/recipe_viewmodel.dart';
import '../widgets/total_widget.dart';
import 'package:floralfigures/widgets/input_field.dart';

class AddRecipePage extends StatefulWidget {
  final String? recipeId;

  const AddRecipePage({super.key, this.recipeId});

  @override
  AddRecipePageState createState() => AddRecipePageState();
}

class AddRecipePageState extends State<AddRecipePage> {
  late Recipe recipe;
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    final recipeViewModel =
        Provider.of<RecipeViewModel>(context, listen: false);
    recipe = widget.recipeId != null
        ? recipeViewModel.getRecipeById(widget.recipeId!)
        : recipeViewModel.createEmptyRecipe();
    nameController = TextEditingController(text: recipe.name);
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recipeViewModel = Provider.of<RecipeViewModel>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipeId == null ? 'Add Recipe' : 'Edit Recipe'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: AppBarActions.build(
          recipeId: widget.recipeId,
          onDelete: () {
            if (widget.recipeId != null) {
              recipeViewModel.deleteRecipe(widget.recipeId!);
              Navigator.of(context).pop();
            }
          },
          onSave: () {
            recipe.name = nameController.text;
            recipeViewModel.saveRecipe(widget.recipeId, recipe);
            Navigator.of(context).pop();
          },
          onAdd: () async {
            final newItem = await _handleFlowerDialog(context, recipeViewModel,
                recipe: recipe);
            if (newItem != null) {
              recipeViewModel.addItemToRecipe(recipe, newItem);
            }
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft, // Align the widget to the left
              child: InputField(
                hint: "Recipe Name",
                controller: nameController,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: recipe.items.length,
              itemBuilder: (context, index) {
                final item = recipe.items[index];
                return FlowerListItem(
                  item: item,
                  onEdit: () async {
                    final updatedItem = await _handleFlowerDialog(
                        context, recipeViewModel,
                        recipe: recipe, itemIndex: index);
                    if (updatedItem != null) {
                      recipeViewModel.updateItemInRecipe(
                          recipe, index, updatedItem);
                    }
                  },
                  onDelete: () =>
                      recipeViewModel.removeItemFromRecipe(recipe, index),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TotalsWidget(
              totalCost: recipeViewModel.calculateTotalCost(recipe),
              totalCostIncVAT: recipeViewModel.calculateTotalCostIncVAT(recipe),
              totalCostIncMarkup:
                  recipeViewModel.calculateTotalCostIncMarkup(recipe),
              subtotal: recipeViewModel.calculateSubtotal(recipe),
              guidePrice: recipeViewModel.calculateGuidePrice(recipe),
              vatController:
                  TextEditingController(text: recipe.vatPercentage.toString()),
              markupController:
                  TextEditingController(text: recipe.markup.toString()),
              sundriesController:
                  TextEditingController(text: recipe.sundries.toString()),
              labourPercentageController: TextEditingController(
                  text: recipe.labourPercentage.toString()),
              retailPriceController:
                  TextEditingController(text: recipe.retailPrice.toString()),
              onChanged: (value) {
                recipeViewModel.updateRecipeCalculations(recipe);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<RecipeItem?> _handleFlowerDialog(
      BuildContext context, RecipeViewModel recipeViewModel,
      {required Recipe recipe, int? itemIndex}) async {
    final RecipeItem? item = itemIndex != null ? recipe.items[itemIndex] : null;
    Flower? selectedFlower = item?.flower;
    final TextEditingController stemQuantityController =
        TextEditingController(text: item?.quantity.toString() ?? "1");

    final RecipeItem? newItem = await showDialog<RecipeItem>(
      context: context,
      builder: (BuildContext context) {
        return AddFlowerDialog(
          stemQuantityController: stemQuantityController,
          selectedFlower: selectedFlower,
          onFlowerChanged: (Flower? newValue) {
            selectedFlower = newValue;
          },
          onSave: () {
            if (selectedFlower != null &&
                stemQuantityController.text.isNotEmpty) {
              final int stems = int.tryParse(stemQuantityController.text) ?? 0;
              Navigator.of(context)
                  .pop(RecipeItem(flower: selectedFlower!, quantity: stems));
            }
          },
          onCancel: () {
            Navigator.of(context).pop();
          },
        );
      },
    );

    return newItem;
  }
}
