import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:floralfigures/features/flowermarket/view/pages/flower_market_page.dart';
import 'package:floralfigures/features/home/view/pages/home_page.dart';
import 'package:floralfigures/features/recipebook/view/pages/recipe_book_page.dart';
import 'package:floralfigures/features/recipebook/view/pages/add_recipe_page.dart';
import 'package:floralfigures/features/shoppingtrip/view/pages/shopping_trip_page.dart';
import 'package:floralfigures/features/shoppingtrip/view/pages/add_shopping_trip_page.dart';
import 'package:floralfigures/features/flowermarket/viewmodel/flower_market_viewmodel.dart';
import 'package:floralfigures/features/recipebook/viewmodel/recipe_viewmodel.dart';
import 'package:floralfigures/features/shoppingtrip/viewmodel/shopping_trip_viewmodel.dart'; // Import the ShoppingTripViewModel
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
        ChangeNotifierProvider<FlowerMarketViewModel>(
          create: (context) => FlowerMarketViewModel(),
        ),
        ChangeNotifierProxyProvider<FlowerMarketViewModel, RecipeViewModel>(
          create: (context) => RecipeViewModel(
              Provider.of<FlowerMarketViewModel>(context, listen: false)),
          update: (context, flowerMarketViewModel, recipeViewModel) {
            recipeViewModel ??= RecipeViewModel(flowerMarketViewModel);
            return recipeViewModel;
          },
        ),
        ChangeNotifierProvider(create: (_) => ShoppingTripViewModel()),
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
          '/shopping_trip': (context) => ShoppingTripPage(),
          '/add_shopping_trip': (context) => AddShoppingTripPage(),
        },
      ),
    );
  }
}
