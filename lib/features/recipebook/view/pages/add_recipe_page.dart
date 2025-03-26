import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../widgets/labeled_text_field.dart';
import '../../../flowermarket/model/flower_model.dart';
import '../widgets/add_flower_to_recipe_dialog.dart';
import '../../model/recipe_model.dart';
import '../../viewmodel/recipe_viewmodel.dart';
import '../widgets/total_widget.dart';

class AddRecipePage extends StatefulWidget {
  final int? recipeIndex;

  const AddRecipePage({super.key, this.recipeIndex});

  @override
  AddRecipePageState createState() => AddRecipePageState();
}

class AddRecipePageState extends State<AddRecipePage> {
  final TextEditingController _nameController = TextEditingController();
  final List<RecipeItem> _items = [];
  final TextEditingController _stemQuantityController = TextEditingController();
  final TextEditingController _vatController =
      TextEditingController(text: '20');
  final TextEditingController _markupController =
      TextEditingController(text: '1');
  final TextEditingController _sundriesController =
      TextEditingController(text: '1');
  final TextEditingController _labourPercentageController =
      TextEditingController(text: '15');
  final TextEditingController _retailPriceController = TextEditingController();
  Flower? _selectedFlower;

  @override
  void initState() {
    super.initState();
    if (widget.recipeIndex != null) {
      final recipe = Provider.of<RecipeViewModel>(context, listen: false)
          .recipes[widget.recipeIndex!];
      _nameController.text = recipe.name;
      _items.addAll(recipe.items);
      _vatController.text = recipe.vatPercentage.toString();
      _markupController.text = recipe.markup.toString();
      _sundriesController.text = recipe.sundries.toString();
      _labourPercentageController.text = recipe.labourPercentage.toString();
      _retailPriceController.text = recipe.retailPrice.toString();
    }
  }

  void _showAddFlowerDialog(BuildContext context, {int? itemIndex}) async {
    final RecipeItem? item = itemIndex != null ? _items[itemIndex] : null;
    if (item != null) {
      _selectedFlower = item.flower;
      _stemQuantityController.text = item.quantity.toString();
    } else {
      _selectedFlower = null;
      _stemQuantityController.text = "1"; // Default value for stems
    }

    final RecipeItem? newItem = await showDialog<RecipeItem>(
      context: context,
      builder: (BuildContext context) {
        return AddFlowerDialog(
          stemQuantityController: _stemQuantityController,
          selectedFlower: _selectedFlower,
          onFlowerChanged: (Flower? newValue) {
            setState(() {
              _selectedFlower = newValue;
            });
          },
          onSave: () {
            if (_selectedFlower != null &&
                _stemQuantityController.text.isNotEmpty) {
              final int stems = int.tryParse(_stemQuantityController.text) ?? 0;
              final RecipeItem newItem =
                  RecipeItem(flower: _selectedFlower!, quantity: stems);
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

  void _deleteFlower(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  void _deleteRecipe() {
    if (widget.recipeIndex != null) {
      Provider.of<RecipeViewModel>(context, listen: false)
          .deleteRecipe(widget.recipeIndex!);
      Navigator.of(context).pop();
    }
  }

  void _saveRecipe() {
    final name = _nameController.text;
    final vatPercentage = double.tryParse(_vatController.text) ?? 20.0;
    final markup = double.tryParse(_markupController.text) ?? 1.0;
    final sundries = double.tryParse(_sundriesController.text) ?? 1.0;
    final labourPercentage =
        double.tryParse(_labourPercentageController.text) ?? 15.0;
    final retailPrice = double.tryParse(_retailPriceController.text) ?? 0.0;
    final recipe = Recipe(
      name: name,
      items: _items,
      vatPercentage: vatPercentage,
      markup: markup,
      sundries: sundries,
      labourPercentage: labourPercentage,
      retailPrice: retailPrice,
    );

    if (widget.recipeIndex == null) {
      Provider.of<RecipeViewModel>(context, listen: false).addRecipe(recipe);
    } else {
      Provider.of<RecipeViewModel>(context, listen: false)
          .editRecipe(widget.recipeIndex!, recipe);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final recipeViewModel = Provider.of<RecipeViewModel>(context);
    final recipe = Recipe(
      name: _nameController.text,
      items: _items,
      vatPercentage: double.tryParse(_vatController.text) ?? 20.0,
      markup: double.tryParse(_markupController.text) ?? 1.0,
      sundries: double.tryParse(_sundriesController.text) ?? 1.0,
      labourPercentage:
          double.tryParse(_labourPercentageController.text) ?? 15.0,
      retailPrice: double.tryParse(_retailPriceController.text) ?? 0.0,
    );

    final totalCost = recipeViewModel.calculateTotalCost(recipe);
    final totalCostIncVAT = recipeViewModel.calculateTotalCostIncVAT(recipe);
    final totalCostIncMarkup =
        recipeViewModel.calculateTotalCostIncMarkup(recipe);
    final subtotal = recipeViewModel.calculateSubtotal(recipe);
    final guidePrice = recipeViewModel.calculateGuidePrice(recipe);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Recipe'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          if (widget.recipeIndex != null)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: _deleteRecipe,
            ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveRecipe,
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddFlowerDialog(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LabeledTextField(
              controller: _nameController,
              label: 'Recipe Name',
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return ListTile(
                  title: Text('${item.flower.name} - ${item.quantity} stems'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _showAddFlowerDialog(context, itemIndex: index);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deleteFlower(index);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TotalsWidget(
              totalCost: totalCost,
              totalCostIncVAT: totalCostIncVAT,
              totalCostIncMarkup: totalCostIncMarkup,
              subtotal: subtotal,
              guidePrice: guidePrice,
              vatController: _vatController,
              markupController: _markupController,
              sundriesController: _sundriesController,
              labourPercentageController: _labourPercentageController,
              retailPriceController: _retailPriceController,
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}
