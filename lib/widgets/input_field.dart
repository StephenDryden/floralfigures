import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
