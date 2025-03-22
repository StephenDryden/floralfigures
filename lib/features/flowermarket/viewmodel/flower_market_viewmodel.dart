import 'package:flutter/material.dart';
import '../model/flower_model.dart';
import '../../recipebook/viewmodel/recipe_viewmodel.dart';

class FlowerMarketViewModel extends ChangeNotifier {
  final List<Flower> _flowerList = [];
  RecipeViewModel recipeViewModel;

  FlowerMarketViewModel(this.recipeViewModel);

  List<Flower> get flowerList => _flowerList;

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
      recipeViewModel.updateFlowerInRecipes(flower, oldFlower);
      return true;
    }
    return false;
  }

  void deleteFlower(int index) {
    final flowerName = _flowerList[index].name;
    _flowerList.removeAt(index);
    recipeViewModel.removeFlowerFromRecipes(flowerName);
    notifyListeners();
  }
}
