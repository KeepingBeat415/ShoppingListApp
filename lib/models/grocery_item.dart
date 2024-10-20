import 'package:shopping_list_app/models/category_type.dart';

class GroceryItem {
  final String id;
  final String name;
  final int quantity;
  final CategoryType categoryType;

  const GroceryItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.categoryType,
  });
}
