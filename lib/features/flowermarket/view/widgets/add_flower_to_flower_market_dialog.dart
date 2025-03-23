import 'package:floralfigures/utils/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:floralfigures/utils/quantity_input_field.dart';

class AddFlowerDialog extends StatefulWidget {
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
  AddFlowerDialogState createState() => AddFlowerDialogState();
}

class AddFlowerDialogState extends State<AddFlowerDialog> {
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
              controller: widget.stemNameController,
            ),
            const SizedBox(
              height: 5,
            ),
            QuantityInputField(
              hint: "Quantity",
              controller: widget.stemQuantityController,
            ),
            const SizedBox(
              height: 5,
            ),
            InputField(
              hint: "Price",
              controller: widget.stemPriceController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyButton(
                  text: "Save",
                  onPressed: widget.onSave,
                ),
                const SizedBox(width: 8),
                MyButton(
                  text: "Cancel",
                  onPressed: widget.onCancel,
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
    this.inputFormatters,
  });

  final String hint;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;

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
                labelStyle: TextStyle(color: Colors.black),
              ),
              controller: controller,
              keyboardType: hint == "Quantity"
                  ? TextInputType.number
                  : TextInputType.text,
              cursorColor: Colors.black,
              inputFormatters: inputFormatters,
            ),
          ),
        ],
      ),
    );
  }
}
