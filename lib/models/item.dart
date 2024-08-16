
import 'package:hive/hive.dart';

part 'item.g.dart';

@HiveType(typeId: 0)
class Item {
  @HiveField(0)
  String item;

  @HiveField(1)
  bool itemIsChecked;
  Item({required this.item, required this.itemIsChecked});
}