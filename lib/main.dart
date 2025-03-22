import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:floralfigures/features/flowermarket/view/pages/flower_market_page.dart';
import 'package:floralfigures/features/home/view/pages/home_page.dart';
import 'package:floralfigures/features/recipebook/view/pages/recipe_book_page.dart';
import 'package:floralfigures/features/recipebook/view/pages/add_recipe_page.dart';
import 'package:floralfigures/features/shoppinglist/view/pages/shopping_list_page.dart';
import 'package:floralfigures/features/flowermarket/viewmodel/flower_market_viewmodel.dart';
import 'package:floralfigures/features/recipebook/viewmodel/recipe_viewmodel.dart';
//import 'package:floralfigures/features/shoppinglist/viewmodel/shopping_list_viewmodel.dart';
import 'package:floralfigures/themes/color.dart';
import 'package:floralfigures/themes/text.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecipeViewModel()),
        ChangeNotifierProxyProvider<RecipeViewModel, FlowerMarketViewModel>(
          create: (context) => FlowerMarketViewModel(
            Provider.of<RecipeViewModel>(context, listen: false),
          ),
          update: (context, recipeViewModel, flowerMarketViewModel) {
            flowerMarketViewModel?.recipeViewModel = recipeViewModel;
            return flowerMarketViewModel!;
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: textTheme,
          useMaterial3: true,
          colorScheme: colorScheme,
          scaffoldBackgroundColor:
              const Color.fromARGB(255, 244, 221, 229), // background color
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/flower_market': (context) => FlowerMarketPage(),
          '/recipe_book': (context) => RecipePage(),
          '/add_recipe': (context) => AddRecipePage(),
          '/shopping_list': (context) => ShoppingListPage(),
        },
      ),
    );
  }
}
