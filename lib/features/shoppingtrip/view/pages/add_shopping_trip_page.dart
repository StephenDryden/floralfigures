import 'package:floralfigures/features/recipebook/model/recipe_model.dart';
import 'package:floralfigures/features/shoppingtrip/model/shopping_trip_model.dart';
import 'package:floralfigures/features/shoppingtrip/viewmodel/shopping_trip_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/labeled_text_field.dart';
import '../widgets/add_recipe_to_trip_dialog.dart';

class AddShoppingTripPage extends StatefulWidget {
  final int? shoppingTripIndex;

  const AddShoppingTripPage({super.key, this.shoppingTripIndex});

  @override
  AddShoppingTripPageState createState() => AddShoppingTripPageState();
}

class AddShoppingTripPageState extends State<AddShoppingTripPage> {
  final TextEditingController _nameController = TextEditingController();
  final List<ShoppingTripItem> _items = [];
  final TextEditingController _quantityController = TextEditingController();
  Recipe? _selectedRecipe;

  @override
  void initState() {
    super.initState();
    if (widget.shoppingTripIndex != null) {
      final shoppingTrip =
          Provider.of<ShoppingTripViewModel>(context, listen: false)
              .shoppingTrips[widget.shoppingTripIndex!];
      _nameController.text = shoppingTrip.name;
      _items.addAll(shoppingTrip.items);
    }
  }

  void _showAddRecipeDialog(BuildContext context, {int? itemIndex}) async {
    final ShoppingTripItem? item = itemIndex != null ? _items[itemIndex] : null;
    if (item != null) {
      _selectedRecipe = item.recipe;
      _quantityController.text = item.quantity.toString();
    } else {
      _selectedRecipe = null;
      _quantityController.text = "1"; // Default value for recipe quantity
    }

    final ShoppingTripItem? newItem = await showDialog<ShoppingTripItem>(
      context: context,
      builder: (BuildContext context) {
        return AddRecipeDialog(
          quantityController: _quantityController,
          selectedRecipe: _selectedRecipe,
          onRecipeChanged: (Recipe? newValue) {
            setState(() {
              _selectedRecipe = newValue;
            });
          },
          onSave: () {
            if (_selectedRecipe != null &&
                _quantityController.text.isNotEmpty) {
              final int bouquets = int.tryParse(_quantityController.text) ?? 0;
              final ShoppingTripItem newItem = ShoppingTripItem(
                  recipe: _selectedRecipe!, quantity: bouquets);
              Navigator.of(context).pop(newItem);
            }
          },
          onCancel: () {
            Navigator.of(context).pop();
          },
        );
      },
    );

    if (newItem != null) {
      setState(() {
        if (itemIndex != null) {
          _items[itemIndex] = newItem;
        } else {
          _items.add(newItem);
        }
      });
    }
  }

  void _deleteRecipe(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  void _deleteShoppingTrip() {
    if (widget.shoppingTripIndex != null) {
      Provider.of<ShoppingTripViewModel>(context, listen: false)
          .deleteShoppingTrip(widget.shoppingTripIndex!);
      Navigator.of(context).pop();
    }
  }

  void _saveShoppingTrip() {
    final name = _nameController.text;
    final shoppingTrip = ShoppingTrip(
      name: name,
      items: _items,
    );

    if (widget.shoppingTripIndex == null) {
      Provider.of<ShoppingTripViewModel>(context, listen: false)
          .addShoppingTrip(shoppingTrip);
    } else {
      Provider.of<ShoppingTripViewModel>(context, listen: false)
          .editShoppingTrip(widget.shoppingTripIndex!, shoppingTrip);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Shopping Trip'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          if (widget.shoppingTripIndex != null)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: _deleteShoppingTrip,
            ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveShoppingTrip,
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddRecipeDialog(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LabeledTextField(
              controller: _nameController,
              label: 'Shopping Trip Name',
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return ListTile(
                  title:
                      Text('${item.recipe.name} - ${item.quantity} bouquets'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _showAddRecipeDialog(context, itemIndex: index);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deleteRecipe(index);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
