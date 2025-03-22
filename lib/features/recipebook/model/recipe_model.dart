import '../../flowermarket/model/flower_model.dart';

class Recipe {
  final String name;
  final List<RecipeItem> items;
  final double vatPercentage;
  final double markup;
  final double sundries;
  final double labourPercentage;
  final double retailPrice;

  Recipe({
    required this.name,
    required this.items,
    this.vatPercentage = 20.0,
    this.markup = 1.0,
    this.sundries = 1.0,
    this.labourPercentage = 15.0,
    this.retailPrice = 0.0,
  });
}

class RecipeItem {
  final Flower flower;
  final int quantity;

  RecipeItem({
    required this.flower,
    required this.quantity,
  });
}
