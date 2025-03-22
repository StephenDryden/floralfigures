import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../utils/menu_drawer.dart';
import '../../viewmodel/recipe_viewmodel.dart';
import 'add_recipe_page.dart';
import 'package:floralfigures/utils/app_bar.dart';

class RecipePage extends StatelessWidget {
  const RecipePage({super.key});

  void _navigateToAddRecipePage(BuildContext context, {int? index}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddRecipePage(recipeIndex: index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          context, () => _navigateToAddRecipePage(context), 'Recipe Book'),
      body: Consumer<RecipeViewModel>(
        builder: (context, viewModel, child) {
          return ListView.builder(
            itemCount: viewModel.recipes.length,
            itemBuilder: (context, index) {
              final recipe = viewModel.recipes[index];
              return Dismissible(
                key: Key(recipe.name),
                onDismissed: (direction) {
                  viewModel.deleteRecipe(index);
                },
                background: Container(color: Colors.red),
                child: ListTile(
                  title: Text(recipe.name),
                  subtitle: Text('Items: ${recipe.items.length}'),
                  onTap: () {
                    _navigateToAddRecipePage(context, index: index);
                  },
                ),
              );
            },
          );
        },
      ),
      drawer: menuDrawer(context),
    );
  }
}
