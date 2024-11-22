import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/repositories/memory_repository.dart';
import '../../models/ingredient.dart';

class GroceriesScreen extends StatefulWidget {
  const GroceriesScreen({Key? key}) : super(key: key);

  @override
  _GroceriesScreenState createState() => _GroceriesScreenState();
}

class _GroceriesScreenState extends State<GroceriesScreen> {
  late Stream<List<Ingredient>> ingredientStream;
  List<Ingredient> currentIngredients = [];

  @override
  void initState() {
    super.initState();
    final repository = Provider.of<MemoryRepository>(context, listen: false);
    ingredientStream = repository.watchAllIngredients();
    ingredientStream.listen((ingredients) {
      setState(() {
        currentIngredients = ingredients;
      });
    });
  }

  void startSearch(String searchString) {
    setState(() {
      currentIngredients = currentIngredients
          .where((ingredient) => ingredient.name?.contains(searchString) ?? false)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Groceries')),
      body: Column(
        children: [
          TextField(
            onChanged: startSearch,
            decoration: const InputDecoration(
              labelText: 'Search ingredients',
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: currentIngredients.length,
              itemBuilder: (context, index) {
                final ingredient = currentIngredients[index];
                return ListTile(
                  title: Text(ingredient.name ?? 'Unknown'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
