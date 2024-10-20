import 'package:flutter/material.dart';
import 'package:shopping_list_app/models/category_type.dart';

const categoriesList = {
  CategoriesList.vegetables: CategoryType(
    'Vegetables',
    Color.fromARGB(255, 0, 255, 128),
  ),
  CategoriesList.fruit: CategoryType(
    'Fruit',
    Color.fromARGB(255, 145, 255, 0),
  ),
  CategoriesList.meat: CategoryType(
    'Meat',
    Color.fromARGB(255, 255, 102, 0),
  ),
  CategoriesList.dairy: CategoryType(
    'Dairy',
    Color.fromARGB(255, 0, 208, 255),
  ),
  CategoriesList.carbs: CategoryType(
    'Carbs',
    Color.fromARGB(255, 0, 60, 255),
  ),
  CategoriesList.sweets: CategoryType(
    'Sweets',
    Color.fromARGB(255, 255, 149, 0),
  ),
  CategoriesList.spices: CategoryType(
    'Spices',
    Color.fromARGB(255, 255, 187, 0),
  ),
  CategoriesList.convenience: CategoryType(
    'Convenience',
    Color.fromARGB(255, 191, 0, 255),
  ),
  CategoriesList.hygiene: CategoryType(
    'Hygiene',
    Color.fromARGB(255, 149, 0, 255),
  ),
  CategoriesList: CategoryType(
    'Other',
    Color.fromARGB(255, 0, 225, 255),
  ),
};
