import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class ItemTile extends StatelessWidget {
  final String itemName;
  final double itemQuantity;
  final double itemPrice;
  final double itemVAT;
  final double itemMarkUp;
  final int totalPrice;
  final Function(BuildContext)? deleteFunction;

  ItemTile(
      {super.key,
      required this.itemName,
      required this.itemQuantity,
      required this.itemPrice,
      required this.itemVAT,
      required this.itemMarkUp,
      required this.totalPrice,
      required this.deleteFunction});

  final NumberFormat ukCurrency = NumberFormat.currency(
    locale: "en_GB",
    symbol: "£",
    decimalDigits: 2,
    name: "GBP",
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              borderRadius: const BorderRadius.all(Radius.circular(12))),
        ]),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(Icons.shopping_basket),
                  ),
                  // Item name
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      itemName,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  // Item Quantity
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      itemQuantity.toString(),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  // Item Price
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Text(
                      ukCurrency.format(itemPrice),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  // itemVAT
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      itemVAT.toString(),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  // itemMarkUp
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Text(
                      itemMarkUp.toString(),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  // Item Total
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 100,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25))),
                        child: Text(
                          ukCurrency.format(totalPrice),
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
