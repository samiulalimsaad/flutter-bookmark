import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/repositories/memory_repository.dart';
import '../../models/recipe.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({Key? key}) : super(key: key);

  @override
  _BookmarksScreenState createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  late Stream<List<Recipe>> recipeStream;

  @override
  void initState() {
    super.initState();
    final repository = Provider.of<MemoryRepository>(context, listen: false);
    recipeStream = repository.watchAllRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bookmarks')),
      body: StreamBuilder<List<Recipe>>(
        stream: recipeStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final recipes = snapshot.data ?? [];
            return ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return ListTile(
                  title: Text(recipe.name),
                  subtitle: Text('Ingredients: ${recipe.ingredients.length}'),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
