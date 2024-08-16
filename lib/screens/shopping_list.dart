import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list_app/data/hiveboxes.dart';
import 'package:shopping_list_app/models/item.dart';
import 'package:shopping_list_app/providers/item_provider.dart';

// ignore: must_be_immutable
class ShoppingListScreen extends StatelessWidget {
  ShoppingListScreen({super.key});

  var itemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var itemProvider = Provider.of<Items>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xfff0f2f5),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Row(
          children: [
            Expanded(
              flex: 1,
              child: Consumer<Items>(
                builder: (_, items, __) {
                  return IconButton(
                    onPressed: () {
                      itemProvider.checkAllItem();
                    },
                    icon: const Icon(
                      Icons.check_circle_outline,
                    ),
                  );
                },
              ),
            ),
            const Expanded(
              flex: 10,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 25,
                ),
                child: Text('Shopping List'),
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () {
                  itemProvider.clear();
                },
                icon: const Icon(Icons.cleaning_services),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Card(
                elevation: 2,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: itemController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Item',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, right: 40, bottom: 30),
                      child: GestureDetector(
                        onTap: () {
                          if (itemController.text.isNotEmpty) {
                            itemProvider.addItem(Item(item: itemController.text, itemIsChecked: false));
                            itemController.clear();
                          }
                        },
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Add',
                            style: TextStyle(
                              color: Colors.purple,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Consumer<Items>(
                  builder: (_, items, c) {
                    return ListView.builder(
                      itemCount: itemBox.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Card(
                          elevation: 2,
                          child: ListTile(
                            title: Text(
                              itemBox.getAt(index).item,
                              style: TextStyle(
                                decoration: itemBox.getAt(index).itemIsChecked
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                itemProvider.toggleItemChecked(index);
                              },
                              icon: Icon(
                                itemBox.getAt(index).itemIsChecked == true
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}