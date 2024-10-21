import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/data/dummy_items.dart';
import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:shopping_list_app/widgets/new_item.dart';
import 'package:http/http.dart'
    as http; // all contents provide by this package should be bundled into 'http' variable/object

import 'dart:convert';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  //var _isLoading = true;
  late Future<List<GroceryItem>>
      _loadedItems; // 'late' will assign value to it before use it
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadedItems = _loadItem();
  }

  Future<List<GroceryItem>> _loadItem() async {
    final url = Uri.https(
        'flutter-prep-default-rtdb.firebaseio.com', 'shopping-list.json');

    //   try {
    final response = await http.get(url);

    if (response.statusCode >= 400) {
      throw Exception('Failed to fetch grocery items. Please try again later.');
      // setState(() {
      //   _error = 'Failed to fetch data. Please try again later';
      //   _isLoading = false;
      // });
    }

    if (response.body == 'null') {
      // setState(() {
      //   _isLoading = false;
      // });
      return [];
    }

    final Map<String, dynamic> listData = json.decode(response.body);

    final List<GroceryItem> loadedItems = [];

    for (final item in listData.entries) {
      final categoryType = categories.entries
          .firstWhere(
              (catItem) => catItem.value.title == item.value['category'])
          .value;

      loadedItems.add(GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          categoryType: categoryType));
    }

    return loadedItems;

    // setState(() {
    //   _groceryItems = _loadItems;
    //   _isLoading = false;
    // });
    // } catch (error) {
    //   setState(() {
    //     _error = 'Something went wrong! Please try again later';
    //   });
    // }
  }

  // void _addItem() async {
  //   final newItem = await Navigator.of(context).push<GroceryItem>(
  //     MaterialPageRoute(
  //       builder: (ctx) => const NewItem(),
  //     ),
  //   );
  //   if (newItem == null) {
  //     return;
  //   }
  //   setState(() {
  //     _groceryItems.add(newItem);
  //   });
  // }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );
    if (newItem == null) {
      return;
    }
    setState(() {
      _groceryItems.add(newItem);
    });
  }

  _removeItem(GroceryItem item) async {
    final index = _groceryItems.indexOf(item);
    setState(() {
      _groceryItems.remove(item);
    });

    final url = Uri.https('flutter-prep-default-rtdb.firebaseio.com',
        'shopping-list/${item.id}.json');

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      // Optional: Show error message
      setState(() {
        _groceryItems.insert(index, item);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Widget content = ListView.builder(
    //   itemCount: _groceryItems.length,
    //   itemBuilder: (cxt, index) => Dismissible(
    //     key: ValueKey(_groceryItems[index].id),
    //     onDismissed: (direction) {
    //       _removeItem(_groceryItems[index]);
    //     },
    //     // key for identify which item will be delete
    //     background: Container(
    //       color: Colors.red.withOpacity(0.75),
    //       margin: const EdgeInsets.symmetric(
    //         horizontal: 4,
    //       ),
    //     ),
    //     child: ListTile(
    //       title: Text(_groceryItems[index].name),
    //       leading: Container(
    //         width: 24,
    //         height: 24,
    //         color: _groceryItems[index].categoryType.color,
    //       ),
    //       trailing: Text(
    //         _groceryItems[index].quantity.toString(),
    //       ),
    //     ),
    //   ),
    // );

    // if (_isLoading) {
    //   content = const Center(
    //     child: CircularProgressIndicator(),
    //   );
    // }

    // if (_groceryItems.isEmpty && _isLoading == false) {
    //   content = Center(
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         Text(
    //           'Uh oh ... nothing here!',
    //           style: Theme.of(context)
    //               .textTheme
    //               .headlineLarge!
    //               .copyWith(color: Theme.of(context).colorScheme.onSurface),
    //         ),
    //         const SizedBox(
    //           height: 16,
    //         ),
    //         Text(
    //           'Try adding something into grocery list!',
    //           style: Theme.of(context)
    //               .textTheme
    //               .bodyLarge!
    //               .copyWith(color: Theme.of(context).colorScheme.onSurface),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    // if (_error != null) {
    //   content = Center(
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         Text(
    //           _error.toString(),
    //           style: Theme.of(context)
    //               .textTheme
    //               .headlineLarge!
    //               .copyWith(color: Theme.of(context).colorScheme.onSurface),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _loadedItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    snapshot.error.toString(),
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                ],
              ),
            );
          }

          if (snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Uh oh ... nothing here!',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Try adding something into grocery list!',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (cxt, index) => Dismissible(
              key: ValueKey(snapshot.data![index].id),
              onDismissed: (direction) {
                _removeItem(snapshot.data![index]);
              },
              // key for identify which item will be delete
              background: Container(
                color: Colors.red.withOpacity(0.75),
                margin: const EdgeInsets.symmetric(
                  horizontal: 4,
                ),
              ),
              child: ListTile(
                title: Text(snapshot.data![index].name),
                leading: Container(
                  width: 24,
                  height: 24,
                  color: snapshot.data![index].categoryType.color,
                ),
                trailing: Text(
                  snapshot.data![index].quantity.toString(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
