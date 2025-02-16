import 'package:flutter/material.dart';
import '../model/flower_model.dart';
import '../../recipebook/viewmodel/recipe_viewmodel.dart';

class FlowerMarketViewModel extends ChangeNotifier {
  final List<Flower> _flowerList = [];
  RecipeViewModel _recipeViewModel;

  FlowerMarketViewModel(this._recipeViewModel);

  List<Flower> get flowerList => _flowerList;

  RecipeViewModel get recipeViewModel => _recipeViewModel;

  set recipeViewModel(RecipeViewModel value) {
    _recipeViewModel = value;
  }

  bool addFlower(Flower flower) {
    if (_flowerList.any((f) => f.name == flower.name)) {
      return false;
    }
    _flowerList.add(flower);
    notifyListeners();
    return true;
  }

  bool editFlower(int index, Flower flower) {
    if (index >= 0 && index < _flowerList.length) {
      final oldFlower = _flowerList[index];
      if (_flowerList.any((f) => f.name == flower.name && f != oldFlower)) {
        return false;
      }
      _flowerList[index] = flower;
      notifyListeners();
      _recipeViewModel.updateFlowerInRecipes(flower, oldFlower);
      return true;
    }
    return false;
  }

  void deleteFlower(int index) {
    final flowerName = _flowerList[index].name;
    _flowerList.removeAt(index);
    _recipeViewModel.removeFlowerFromRecipes(flowerName);
    notifyListeners();
  }
}
