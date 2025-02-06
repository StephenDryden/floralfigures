import 'package:floralfigures/utils/app_bar.dart';
import 'package:floralfigures/utils/dialog_box.dart';
import 'package:floralfigures/utils/header_tile.dart';
import 'package:floralfigures/utils/item_tile.dart';
import 'package:floralfigures/utils/total_tile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List itemList = [
    ["Rose", 1.0, 1.00, 20.0, 2.0, 2],
    ["Daffodils", 2.0, 0.50, 20.0, 2.0, 12],
  ];

  // text controller
  final _itemNameController = TextEditingController();
  final _itemQuantityController = TextEditingController(text: "1.0");
  final _itemPriceController = TextEditingController(text: "0.00");
  final _itemVATController = TextEditingController(text: "20");
  final _itemMarkUpController = TextEditingController(text: "2.0");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, createItem),
      body: Column(
        children: [
          const Column(
            children: [
              HeaderTile(),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                return ItemTile(
                  itemName: itemList[index][0],
                  itemQuantity: itemList[index][1],
                  itemPrice: itemList[index][2],
                  itemVAT: itemList[index][3],
                  itemMarkUp: itemList[index][4],
                  totalPrice: itemList[index][5],
                  deleteFunction: (context) => deleteItem(index),
                );
              },
            ),
          ),
          Column(
            children: [
              TotalTile(
                total: calculateTotal(),
              )
            ],
          )
        ],
      ),
    );
  }

  void saveItem() {
    setState(() {
      String itemName = _itemNameController.text;
      double itemQuantity = double.parse(_itemQuantityController.text);
      double itemPrice = double.parse(_itemPriceController.text);
      double itemVAT = double.parse(_itemVATController.text);
      double itemMarkUp = double.parse(_itemMarkUpController.text);
      double totalPrice =
          itemQuantity * itemPrice * (1 + itemVAT / 100) * itemMarkUp;

      int roundedTotalPrice = totalPrice.ceil();

      itemList.add([
        itemName,
        itemQuantity,
        itemPrice,
        itemVAT,
        itemMarkUp,
        roundedTotalPrice
      ]);

      _itemNameController.clear();
      _itemQuantityController.text = "1";
      _itemPriceController.text = "0.00";
      _itemVATController.text = "20.0";
      _itemMarkUpController.text = "2.0";
    });
    Navigator.of(context).pop();
  }

  void deleteItem(int index) {
    setState(() {
      itemList.removeAt(index);
    });
  }

  double calculateTotal() {
    double total = 0.00;

    for (final item in itemList) {
      total = total + item[5];
    }

    return total;
  }

// create a new task
  void createItem() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          itemNameController: _itemNameController,
          itemQuantityController: _itemQuantityController,
          itemPriceController: _itemPriceController,
          itemVATController: _itemVATController,
          itemMarkUpController: _itemMarkUpController,
          onSave: saveItem,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }
}
