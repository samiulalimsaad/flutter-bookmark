import 'package:bookmark_lab/ui/groceries/groceries.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/repositories/memory_repository.dart';
import 'ui/bookmarks/bookmarks.dart';
import 'ui/recipes/recipes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => MemoryRepository(),
      child: MaterialApp(
        title: 'Grocery & Recipe App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grocery & Recipe App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RecipesScreen()),
              );
            },
            child: const Text('Recipes'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BookmarksScreen()),
              );
            },
            child: const Text('Bookmarks'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GroceriesScreen()),
              );
            },
            child: const Text('Groceries'),
          ),
        ],
      ),
    );
  }
}
