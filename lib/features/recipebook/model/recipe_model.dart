import 'package:uuid/uuid.dart';
import '../../flowermarket/model/flower_model.dart';

class Recipe {
  String id; // Unique identifier
  String name; // Removed 'final' to allow updates
  List<RecipeItem> items;
  double vatPercentage;
  double markup;
  double sundries;
  double labourPercentage;
  double retailPrice;

  Recipe({
    String? id,
    required this.name,
    required this.items,
    this.vatPercentage = 20.0,
    this.markup = 1.0,
    this.sundries = 1.0,
    this.labourPercentage = 15.0,
    this.retailPrice = 0.0,
  }) : id = id ?? const Uuid().v4(); // Generate ID if not provided
}

class RecipeItem {
  final Flower flower;
  final int quantity;

  RecipeItem({
    required this.flower,
    required this.quantity,
  });
}
