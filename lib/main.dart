import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list_app/data/hiveboxes.dart';
import 'package:shopping_list_app/models/item.dart';
import 'package:shopping_list_app/providers/item_provider.dart';
import 'package:shopping_list_app/screens/shopping_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ItemAdapter());
  itemBox = await Hive.openBox<Item>('itemBox');
  runApp(const ShoppingList());
}

class ShoppingList extends StatelessWidget {
  const ShoppingList({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Items(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ShoppingListScreen(),
      ),
    );
  }
}
