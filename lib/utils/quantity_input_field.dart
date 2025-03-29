import 'package:flutter/material.dart';

class QuantityInputField extends StatelessWidget {
  const QuantityInputField({
    super.key,
    required this.hint,
    required this.controller,
    this.onChanged,
  });

  final String hint;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "$hint:",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              int currentValue = int.tryParse(controller.text) ?? 0;
              if (currentValue > 0) {
                controller.text = (currentValue - 1).toString();
                if (onChanged != null) onChanged!(controller.text);
              }
            },
          ),
          SizedBox(
            width: 50,
            child: TextField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 10),
              ),
              controller: controller,
              keyboardType: TextInputType.number,
              cursorColor: Colors.black,
              textAlign: TextAlign.center,
              onChanged: onChanged,
            ),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              int currentValue = int.tryParse(controller.text) ?? 0;
              controller.text = (currentValue + 1).toString();
              if (onChanged != null) onChanged!(controller.text);
            },
          ),
        ],
      ),
    );
  }
}
