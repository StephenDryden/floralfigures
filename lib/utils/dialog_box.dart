import 'package:floralfigures/utils/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:floralfigures/utils/quantity_input_field.dart';
import 'package:floralfigures/widgets/input_field.dart'; // Import reusable InputField

class DialogBox extends StatelessWidget {
  final TextEditingController itemNameController;
  final TextEditingController itemQuantityController;
  final TextEditingController itemPriceController;
  final TextEditingController itemVATController;
  final TextEditingController itemMarkUpController;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const DialogBox({
    super.key,
    required this.itemNameController,
    required this.itemQuantityController,
    required this.itemPriceController,
    required this.itemVATController,
    required this.itemMarkUpController,
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
              controller: itemNameController,
            ),
            const SizedBox(
              height: 5,
            ),
            QuantityInputField(
              hint: "Quantity",
              controller: itemQuantityController,
            ),
            const SizedBox(
              height: 5,
            ),
            InputField(
              hint: "Price",
              controller: itemPriceController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            InputField(
              hint: "VAT",
              controller: itemVATController,
            ),
            const SizedBox(
              height: 5,
            ),
            InputField(
              hint: "Mark Up",
              controller: itemMarkUpController,
            ),
            const SizedBox(
              height: 5,
            ),
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
