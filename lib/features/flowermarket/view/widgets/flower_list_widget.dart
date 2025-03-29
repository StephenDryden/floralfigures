import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/flower_market_viewmodel.dart';

class FlowerListWidget extends StatelessWidget {
  final void Function(String id) onEdit;

  const FlowerListWidget({super.key, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Consumer<FlowerMarketViewModel>(
      builder: (context, viewModel, child) {
        return ListView.builder(
          itemCount: viewModel.flowerList.length,
          itemBuilder: (context, index) {
            final flower = viewModel.flowerList[index];
            return ListTile(
              title: Text(flower.name),
              subtitle: Text(
                  'Price per stem:       £${flower.pricePerStem}\nStems per bundle:  ${flower.stemsPerBundle}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => onEdit(flower.id),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      viewModel.deleteFlower(flower.id);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
