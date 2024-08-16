import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/hiveboxes.dart';
import 'package:shopping_list_app/models/item.dart';

class Items extends ChangeNotifier {
  Future<void> addItem(Item item) async {
    await itemBox.add(item);
    notifyListeners();
  }

  void toggleItemChecked(int index) {
    Item item = itemBox.getAt(index);
    item.itemIsChecked = !item.itemIsChecked;
    itemBox.putAt(index, item);
    notifyListeners();
  }

  void checkAllItem() {
    bool shouldCheck = !areAllItemsChecked();

    for (int i = 0; i < itemBox.length; i++) {
      Item item = itemBox.getAt(i);
      item.itemIsChecked = shouldCheck;
      itemBox.putAt(i, item);
    }

    notifyListeners();
  }

  bool areAllItemsChecked() {
    for (int i = 0; i < itemBox.length; i++) {
      if (!itemBox.getAt(i).itemIsChecked) {
        return false;
      }
    }
    return true;
  }

  Future<void> clear() async {
    for (int i = itemBox.length - 1; i >= 0; i--) {
      if (itemBox.getAt(i).itemIsChecked) {
        await itemBox.deleteAt(i);
      }
    }
    notifyListeners();
  }
}