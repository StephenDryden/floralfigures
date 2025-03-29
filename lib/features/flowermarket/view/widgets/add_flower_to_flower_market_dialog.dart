import 'package:floralfigures/utils/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:floralfigures/utils/quantity_input_field.dart';
import 'package:floralfigures/widgets/input_field.dart'; // Import reusable InputField

class AddFlowerDialog extends StatelessWidget {
  final TextEditingController stemNameController;
  final TextEditingController stemQuantityController;
  final TextEditingController stemPriceController;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const AddFlowerDialog({
    super.key,
    required this.stemNameController,
    required this.stemQuantityController,
    required this.stemPriceController,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2))),
      content: SizedBox(
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InputField(
              hint: "Name",
              controller: stemNameController,
            ),
            const SizedBox(height: 5),
            QuantityInputField(
              hint: "Quantity",
              controller: stemQuantityController,
            ),
            const SizedBox(height: 5),
            InputField(
              hint: "Price",
              controller: stemPriceController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
              ],
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
