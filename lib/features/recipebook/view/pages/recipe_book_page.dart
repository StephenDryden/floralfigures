import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../utils/menu_drawer.dart';
import '../../viewmodel/recipe_viewmodel.dart';
import 'add_recipe_page.dart';
import 'package:floralfigures/utils/app_bar.dart';

class RecipePage extends StatelessWidget {
  const RecipePage({super.key});

  void _navigateToAddRecipePage(BuildContext context, {String? recipeId}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddRecipePage(
          recipeId: recipeId, // Pass recipeId instead of index
        ),
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
              return ListTile(
                title: Text(
                  '${recipe.name} - £${recipe.retailPrice}',
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _navigateToAddRecipePage(context,
                            recipeId: recipe.id); // Pass recipe.id
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        viewModel.deleteRecipe(recipe.id); // Use recipe.id
                      },
                    ),
                  ],
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
