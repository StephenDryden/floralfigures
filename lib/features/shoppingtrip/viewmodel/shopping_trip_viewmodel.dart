import 'package:flutter/material.dart';
import '../../recipebook/model/recipe_model.dart';
import '../model/shopping_trip_model.dart';

class ShoppingTripViewModel extends ChangeNotifier {
  final List<ShoppingTrip> _shoppingTrips = [];

  ShoppingTripViewModel();

  List<ShoppingTrip> get shoppingTrips => _shoppingTrips;

  void addShoppingTrip(ShoppingTrip shoppingTrip) {
    _shoppingTrips.add(shoppingTrip);
    notifyListeners();
  }

  void editShoppingTrip(int index, ShoppingTrip shoppingTrip) {
    _shoppingTrips[index] = shoppingTrip;
    notifyListeners();
  }

  void deleteShoppingTrip(int index) {
    _shoppingTrips.removeAt(index);
    notifyListeners();
  }

  void updateRecipeShoppingTrips(Recipe newRecipe, Recipe oldRecipe) {
    for (var shoppingTrip in _shoppingTrips) {
      for (var i = 0; i < shoppingTrip.items.length; i++) {
        if (shoppingTrip.items[i].recipe.name == oldRecipe.name) {
          shoppingTrip.items[i] = ShoppingTripItem(
            recipe: newRecipe,
            quantity: shoppingTrip.items[i].quantity,
          );
        }
      }
    }
    notifyListeners();
  }

  void removeFlowerFromShoppingTrips(String recipeName) {
    for (var shoppingTrip in _shoppingTrips) {
      shoppingTrip.items.removeWhere((item) => item.recipe.name == recipeName);
    }
    notifyListeners();
  }

  Map<String, int> summarizeFlowers() {
    final flowerTotals = <String, int>{};

    for (var shoppingTrip in _shoppingTrips) {
      for (var item in shoppingTrip.items) {
        final recipe = item.recipe;
        final quantity = item.quantity;

        for (var recipeItem in recipe.items) {
          final flowerType = recipeItem.flower.name;
          final flowerQuantity = recipeItem.quantity * quantity;

          flowerTotals[flowerType] =
              (flowerTotals[flowerType] ?? 0) + flowerQuantity;
        }
      }
    }

    return flowerTotals;
  }
}
