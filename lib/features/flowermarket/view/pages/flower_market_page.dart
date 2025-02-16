import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/flower_model.dart';
import '../../viewmodel/flower_market_viewmodel.dart';
import 'package:floralfigures/features/flowermarket/view/widgets/add_flower_to_flower_market_dialog.dart';
import 'package:floralfigures/utils/app_bar.dart';
import 'package:floralfigures/utils/menu_drawer.dart';

class FlowerMarketPage extends StatelessWidget {
  const FlowerMarketPage({super.key});

  void _showAddFlowerDialog(BuildContext context, {int? index}) {
    final stemNameController = TextEditingController();
    final stemQuantityController = TextEditingController(text: "10");
    final stemPriceController = TextEditingController(text: "0.50");

    if (index != null) {
      final flower = Provider.of<FlowerMarketViewModel>(context, listen: false)
          .flowerList[index];
      stemNameController.text = flower.name;
      stemQuantityController.text = flower.stemsPerBundle.toString();
      stemPriceController.text = flower.pricePerStem.toString();
    } else {
      stemNameController.clear();
      stemQuantityController.text = "10";
      stemPriceController.text = "0.50";
    }

    showDialog(
      context: context,
      builder: (context) {
        return AddFlowerDialog(
          stemNameController: stemNameController,
          stemQuantityController: stemQuantityController,
          stemPriceController: stemPriceController,
          onSave: () {
            final name = stemNameController.text;
            final price = double.tryParse(stemPriceController.text) ?? 0.0;
            final stems = int.tryParse(stemQuantityController.text) ?? 0;

            final flower =
                Flower(name: name, pricePerStem: price, stemsPerBundle: stems);

            if (index == null) {
              if (!_addFlower(context, flower)) {
                _showFlowerExistsDialog(context);
                return;
              }
            } else {
              if (!_editFlower(context, index, flower)) {
                _showFlowerExistsDialog(context);
                return;
              }
            }

            Navigator.of(context).pop();
          },
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
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

  bool _addFlower(BuildContext context, Flower flower) {
    final flowerMarketViewModel =
        Provider.of<FlowerMarketViewModel>(context, listen: false);
    return flowerMarketViewModel.addFlower(flower);
  }

  bool _editFlower(BuildContext context, int index, Flower flower) {
    final flowerMarketViewModel =
        Provider.of<FlowerMarketViewModel>(context, listen: false);
    return flowerMarketViewModel.editFlower(index, flower);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          appBar(context, () => _showAddFlowerDialog(context), 'Flower Market'),
      body: Consumer<FlowerMarketViewModel>(
        builder: (context, viewModel, child) {
          return ListView.builder(
            itemCount: viewModel.flowerList.length,
            itemBuilder: (context, index) {
              final flower = viewModel.flowerList[index];
              return ListTile(
                title: Text(flower.name),
                subtitle: Text(
                    'Price per stem: £${flower.pricePerStem} - Stems per bundle: ${flower.stemsPerBundle}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _showAddFlowerDialog(context, index: index);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        viewModel.deleteFlower(index);
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
