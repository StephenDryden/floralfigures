import 'package:flutter/material.dart';
import '../../model/recipe_model.dart';

class FlowerListItem extends StatelessWidget {
  final RecipeItem item;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const FlowerListItem({
    super.key,
    required this.item,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${item.flower.name} - ${item.quantity} stems'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: onEdit,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
