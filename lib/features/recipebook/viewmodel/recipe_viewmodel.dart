import 'package:flutter/material.dart';
import '../../flowermarket/model/flower_model.dart';
import '../model/recipe_model.dart';

class RecipeViewModel extends ChangeNotifier {
  final List<Recipe> _recipes = [];

  List<Recipe> get recipes => _recipes;

  void addRecipe(Recipe recipe) {
    _recipes.add(recipe);
    notifyListeners();
  }

  void editRecipe(int index, Recipe recipe) {
    _recipes[index] = recipe;
    notifyListeners();
  }

  void deleteRecipe(int index) {
    _recipes.removeAt(index);
    notifyListeners();
  }

  void updateFlowerInRecipes(Flower newFlower, Flower oldFlower) {
    for (var recipe in _recipes) {
      for (var i = 0; i < recipe.items.length; i++) {
        if (recipe.items[i].flower.name == oldFlower.name) {
          recipe.items[i] = RecipeItem(
            flower: newFlower,
            quantity: recipe.items[i].quantity,
          );
        }
      }
    }
    notifyListeners();
  }

  void removeFlowerFromRecipes(String flowerName) {
    for (var recipe in _recipes) {
      recipe.items.removeWhere((item) => item.flower.name == flowerName);
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
}
