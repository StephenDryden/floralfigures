import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/flower_model.dart';
import '../../viewmodel/flower_market_viewmodel.dart';
import 'package:floralfigures/features/flowermarket/view/widgets/add_flower_to_flower_market_dialog.dart';
import 'package:floralfigures/utils/app_bar.dart';
import 'package:floralfigures/utils/menu_drawer.dart';
import '../widgets/flower_list_widget.dart';

class FlowerMarketPage extends StatelessWidget {
  const FlowerMarketPage({super.key});

  void _showAddFlowerDialog(BuildContext context, {String? id}) {
    final controllers = _initializeControllers(context, id);

    showDialog(
      context: context,
      builder: (context) {
        return AddFlowerDialog(
          stemNameController: controllers['name']!,
          stemQuantityController: controllers['quantity']!,
          stemPriceController: controllers['price']!,
          onSave: () => _handleSave(context, id, controllers),
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  Map<String, TextEditingController> _initializeControllers(
      BuildContext context, String? id) {
    final nameController = TextEditingController();
    final quantityController = TextEditingController(text: "10");
    final priceController = TextEditingController(text: "0.50");

    if (id != null) {
      final flower = Provider.of<FlowerMarketViewModel>(context, listen: false)
          .flowerList
          .firstWhere((f) => f.id == id);
      nameController.text = flower.name;
      quantityController.text = flower.stemsPerBundle.toString();
      priceController.text = flower.pricePerStem.toString();
    }

    return {
      'name': nameController,
      'quantity': quantityController,
      'price': priceController,
    };
  }

  void _handleSave(BuildContext context, String? id,
      Map<String, TextEditingController> controllers) {
    final name = controllers['name']!.text;
    final price = double.tryParse(controllers['price']!.text) ?? 0.0;
    final stems = int.tryParse(controllers['quantity']!.text) ?? 0;

    final flower = Flower(
      id: id,
      name: name,
      pricePerStem: price,
      stemsPerBundle: stems,
    );

    final flowerMarketViewModel =
        Provider.of<FlowerMarketViewModel>(context, listen: false);

    final success = id == null
        ? flowerMarketViewModel.addFlower(flower)
        : flowerMarketViewModel.editFlower(flower);

    if (!success) {
      _showFlowerExistsDialog(context);
      return;
    }

    Navigator.of(context).pop();
  }

  void _showFlowerExistsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Flower Exists'),
          content: Text('A flower with the same name already exists.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          appBar(context, () => _showAddFlowerDialog(context), 'Flower Market'),
      body: FlowerListWidget(
        onEdit: (id) => _showAddFlowerDialog(context, id: id),
      ),
      drawer: menuDrawer(context),
    );
  }
}
