import 'package:flutter/material.dart';
import '../../../../widgets/labeled_text_field.dart';

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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Total (ex VAT): ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Text(
                    '£${totalCost.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            LabeledTextField(
              label: 'VAT Percentage',
              controller: vatController,
              keyboardType: TextInputType.number,
              onChanged: onChanged,
            ),
            Row(
              children: [
                Text(
                  'Total (inc VAT): ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Text(
                    '£${totalCostIncVAT.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            LabeledTextField(
              label: 'Markup Multiple',
              controller: markupController,
              keyboardType: TextInputType.number,
              onChanged: onChanged,
            ),
            Row(
              children: [
                Text(
                  'Total (inc Markup): ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Text(
                    '£${totalCostIncMarkup.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            LabeledTextField(
              label: 'Sundries',
              controller: sundriesController,
              keyboardType: TextInputType.number,
              onChanged: onChanged,
            ),
            Row(
              children: [
                Text(
                  'Subtotal: ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Text(
                    '£${subtotal.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            LabeledTextField(
              label: 'Labour Percentage',
              controller: labourPercentageController,
              keyboardType: TextInputType.number,
              onChanged: onChanged,
            ),
            Row(
              children: [
                Text(
                  'Guide Price: ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Text(
                    '£${guidePrice.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            LabeledTextField(
              label: 'Retail Price',
              controller: retailPriceController,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }
}
