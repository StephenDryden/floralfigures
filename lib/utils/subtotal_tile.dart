import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SubtotalTile extends StatelessWidget {
  final double subtotal;
  SubtotalTile({
    super.key,
    required this.subtotal,
  });

  final NumberFormat ukCurrency = NumberFormat.currency(
    locale: "en_GB",
    symbol: "£",
    decimalDigits: 2,
    name: "GBP",
  );

  @override
  Widget build(BuildContext context) {
    final NumberFormat ukCurrency = NumberFormat.currency(
      locale: "en_GB",
      symbol: "£",
      decimalDigits: 2,
      name: "GBP",
    );

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Row(
                    children: [
                      Text(
                        "Subtotal: ",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Container(
                        width: 100,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25))),
                        child: Text(
                          ukCurrency.format(subtotal),
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
