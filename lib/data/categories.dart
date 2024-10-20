import 'package:flutter/material.dart';
import 'package:shopping_list_app/models/category_type.dart';

const categories = {
  Categories.vegetables: CategoryType(
    'Vegetables',
    Color.fromARGB(255, 0, 255, 128),
  ),
  Categories.fruit: CategoryType(
    'Fruit',
    Color.fromARGB(255, 145, 255, 0),
  ),
  Categories.meat: CategoryType(
    'Meat',
    Color.fromARGB(255, 255, 102, 0),
  ),
  Categories.dairy: CategoryType(
    'Dairy',
    Color.fromARGB(255, 0, 208, 255),
  ),
  Categories.carbs: CategoryType(
    'Carbs',
    Color.fromARGB(255, 0, 60, 255),
  ),
  Categories.sweets: CategoryType(
    'Sweets',
    Color.fromARGB(255, 255, 149, 0),
  ),
  Categories.spices: CategoryType(
    'Spices',
    Color.fromARGB(255, 255, 187, 0),
  ),
  Categories.convenience: CategoryType(
    'Convenience',
    Color.fromARGB(255, 191, 0, 255),
  ),
  Categories.hygiene: CategoryType(
    'Hygiene',
    Color.fromARGB(255, 149, 0, 255),
  ),
  Categories: CategoryType(
    'Other',
    Color.fromARGB(255, 0, 225, 255),
  ),
};
