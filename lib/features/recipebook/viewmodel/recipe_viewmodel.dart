import 'package:flutter/material.dart';
import '../../flowermarket/model/flower_model.dart';
import '../../flowermarket/viewmodel/flower_market_viewmodel.dart';
import '../model/recipe_model.dart';

class RecipeViewModel extends ChangeNotifier {
  final List<Recipe> _recipes = [];

  RecipeViewModel(FlowerMarketViewModel flowerMarketViewModel) {
    flowerMarketViewModel.addListener(() {
      _updateFlowersInRecipes(flowerMarketViewModel.flowerList);
    });

    flowerMarketViewModel.addListener(() {
      _removeDeletedFlowersFromRecipes(flowerMarketViewModel.flowerList);
    });
  }

  List<Recipe> get recipes => _recipes;

  void addRecipe(Recipe recipe) {
    _recipes.add(recipe);
    notifyListeners();
  }

  void editRecipe(String recipeId, Recipe updatedRecipe) {
    final index = _recipes.indexWhere((recipe) => recipe.id == recipeId);
    if (index != -1) {
      _recipes[index] = updatedRecipe;
      notifyListeners();
    }
  }

  void deleteRecipe(String recipeId) {
    _recipes.removeWhere((recipe) => recipe.id == recipeId);
    notifyListeners();
  }

  void removeFlowerFromRecipes(String flowerId) {
    for (var recipe in _recipes) {
      recipe.items.removeWhere((item) => item.flower.id == flowerId);
    }
    notifyListeners();
  }

  double calculateTotalCost(Recipe recipe) {
    double totalCost = 0.0;
    for (var item in recipe.items) {
      totalCost += item.quantity * item.flower.pricePerStem;
    }
    return totalCost;
  }

  double calculateTotalCostIncVAT(Recipe recipe) {
    final totalCost = calculateTotalCost(recipe);
    return totalCost + (totalCost * recipe.vatPercentage / 100);
  }

  double calculateTotalCostIncMarkup(Recipe recipe) {
    final totalCostIncVAT = calculateTotalCostIncVAT(recipe);
    return totalCostIncVAT * recipe.markup;
  }

  double calculateSubtotal(Recipe recipe) {
    final totalCostIncMarkup = calculateTotalCostIncMarkup(recipe);
    return totalCostIncMarkup + recipe.sundries;
  }

  double calculateGuidePrice(Recipe recipe) {
    final subtotal = calculateSubtotal(recipe);
    return subtotal + (subtotal * recipe.labourPercentage / 100);
  }

  Recipe createRecipe({
    required String name,
    required List<RecipeItem> items,
    required double vatPercentage,
    required double markup,
    required double sundries,
    required double labourPercentage,
    required double retailPrice,
  }) {
    return Recipe(
      name: name,
      items: items,
      vatPercentage: vatPercentage,
      markup: markup,
      sundries: sundries,
      labourPercentage: labourPercentage,
      retailPrice: retailPrice,
    );
  }

  Recipe createEmptyRecipe() {
    return Recipe(
      id: UniqueKey().toString(),
      name: '',
      items: [],
      vatPercentage: 20.0,
      markup: 1.0,
      sundries: 1.0,
      labourPercentage: 15.0,
      retailPrice: 0.0,
    );
  }

  Recipe getRecipeById(String id) {
    return recipes.firstWhere((recipe) => recipe.id == id);
  }

  void saveRecipe(String? recipeId, Recipe recipe) {
    if (recipeId == null) {
      addRecipe(recipe);
    } else {
      editRecipe(recipeId, recipe);
    }
    notifyListeners();
  }

  void addItemToRecipe(Recipe recipe, RecipeItem item) {
    recipe.items.add(item);
    notifyListeners();
  }

  void updateItemInRecipe(Recipe recipe, int index, RecipeItem updatedItem) {
    recipe.items[index] = updatedItem;
    notifyListeners();
  }

  void removeItemFromRecipe(Recipe recipe, int index) {
    recipe.items.removeAt(index);
    notifyListeners();
  }

  void updateRecipeCalculations(Recipe recipe) {
    // Trigger recalculation logic if needed
    notifyListeners();
  }

  void _updateFlowersInRecipes(List<Flower> updatedFlowers) {
    for (var recipe in _recipes) {
      for (var i = 0; i < recipe.items.length; i++) {
        final flower = recipe.items[i].flower;
        final updatedFlower = updatedFlowers.firstWhere(
          (f) => f.id == flower.id, // Match by id
          orElse: () => flower,
        );
        recipe.items[i] = RecipeItem(
          flower: updatedFlower,
          quantity: recipe.items[i].quantity,
        );
      }
    }
    notifyListeners();
  }

  void _removeDeletedFlowersFromRecipes(List<Flower> updatedFlowers) {
    final updatedFlowerIds = updatedFlowers.map((f) => f.id).toSet();
    for (var recipe in _recipes) {
      recipe.items
          .removeWhere((item) => !updatedFlowerIds.contains(item.flower.id));
    }
    notifyListeners();
  }
}
