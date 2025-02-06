import 'package:flutter/material.dart';

class HeaderTile extends StatelessWidget {
  const HeaderTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, top: 10, right: 0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    // Item Quantity
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Quantity",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    // Item Price
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Price",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    // itemVAT
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        "VAT",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    // itemMarkUp
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Mark Up",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    // Item Total
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, right: 20),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Rounded Total",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
