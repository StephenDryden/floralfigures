import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../flowermarket/model/flower_model.dart';
import '../../../flowermarket/viewmodel/flower_market_viewmodel.dart';
import 'package:floralfigures/utils/my_button.dart';

class AddFlowerDialog extends StatelessWidget {
  final TextEditingController stemQuantityController;
  final Flower? selectedFlower;
  final ValueChanged<Flower?> onFlowerChanged;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const AddFlowerDialog({
    super.key,
    required this.stemQuantityController,
    required this.selectedFlower,
    required this.onFlowerChanged,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2))),
      content: SizedBox(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Consumer<FlowerMarketViewModel>(
              builder: (context, flowerViewModel, child) {
                return DropdownButton<Flower>(
                  hint: Text('Select Flower'),
                  value: selectedFlower,
                  onChanged: onFlowerChanged,
                  items: flowerViewModel.flowerList
                      .map<DropdownMenuItem<Flower>>((Flower flower) {
                    return DropdownMenuItem<Flower>(
                      value: flower,
                      child: Text(flower.name),
                    );
                  }).toList(),
                );
              },
            ),
            const SizedBox(height: 5),
            InputField(
              hint: "Quantity",
              controller: stemQuantityController,
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyButton(
                  text: "Save",
                  onPressed: onSave,
                ),
                const SizedBox(width: 8),
                MyButton(
                  text: "Cancel",
                  onPressed: onCancel,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.hint,
    required this.controller,
  });

  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Row(
        children: [
          Text(
            "$hint:",
            style: Theme.of(context).textTheme.labelLarge,
          ),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 10),
              ),
              controller: controller,
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }
}
