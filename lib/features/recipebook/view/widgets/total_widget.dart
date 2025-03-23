import 'package:flutter/material.dart';
import '../../../../utils/quantity_input_field.dart';

class TotalsWidget extends StatelessWidget {
  final double totalCost;
  final double totalCostIncVAT;
  final double totalCostIncMarkup;
  final double subtotal;
  final double guidePrice;
  final TextEditingController vatController;
  final TextEditingController markupController;
  final TextEditingController sundriesController;
  final TextEditingController labourPercentageController;
  final TextEditingController retailPriceController;
  final ValueChanged<String>? onChanged;

  const TotalsWidget({
    super.key,
    required this.totalCost,
    required this.totalCostIncVAT,
    required this.totalCostIncMarkup,
    required this.subtotal,
    required this.guidePrice,
    required this.vatController,
    required this.markupController,
    required this.sundriesController,
    required this.labourPercentageController,
    required this.retailPriceController,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRow('Total (ex VAT):', '£${totalCost.toStringAsFixed(2)}'),
            const SizedBox(height: 10),
            QuantityInputField(
              hint: 'VAT Percentage',
              controller: vatController,
              onChanged: onChanged,
            ),
            const SizedBox(height: 10),
            _buildRow(
                'Total (inc VAT):', '£${totalCostIncVAT.toStringAsFixed(2)}'),
            const SizedBox(height: 10),
            QuantityInputField(
              hint: 'Markup Multiple',
              controller: markupController,
              onChanged: onChanged,
            ),
            const SizedBox(height: 10),
            _buildRow('Total (inc Markup):',
                '£${totalCostIncMarkup.toStringAsFixed(2)}'),
            const SizedBox(height: 10),
            QuantityInputField(
              hint: 'Sundries',
              controller: sundriesController,
              onChanged: onChanged,
            ),
            const SizedBox(height: 10),
            _buildRow('Subtotal:', '£${subtotal.toStringAsFixed(2)}'),
            const SizedBox(height: 10),
            QuantityInputField(
              hint: 'Labour Percentage',
              controller: labourPercentageController,
              onChanged: onChanged,
            ),
            const SizedBox(height: 10),
            _buildRow('Guide Price:', '£${guidePrice.toStringAsFixed(2)}'),
            const SizedBox(height: 10),
            QuantityInputField(
              hint: 'Retail Price',
              controller: retailPriceController,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
