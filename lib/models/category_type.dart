import 'package:flutter/material.dart';

enum CategoriesList {
  vegetables,
  fruit,
  meat,
  dairy,
  carbs,
  sweets,
  spices,
  convenience,
  hygiene,
  other,
}

class CategoryType {
  final String title;
  final Color color;

  const CategoryType(this.title, this.color);
}
