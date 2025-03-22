import '../../recipebook/model/recipe_model.dart';

class ShoppingTrip {
  final String name;
  final List<ShoppingTripItem> items;

  ShoppingTrip({
    required this.name,
    required this.items,
  });
}

class ShoppingTripItem {
  final Recipe recipe;
  final int quantity;

  ShoppingTripItem({
    required this.recipe,
    required this.quantity,
  });
}
