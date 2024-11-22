import 'dart:async';

import '../../models/ingredient.dart';
import '../../models/recipe.dart';
import 'repository.dart';

class MemoryRepository implements Repository {
  late Stream<List<Recipe>> _recipeStream;
  late Stream<List<Ingredient>> _ingredientStream;
  final StreamController<List<Recipe>> _recipeStreamController = StreamController<List<Recipe>>.broadcast();
  final StreamController<List<Ingredient>> _ingredientStreamController = StreamController<List<Ingredient>>.broadcast();

  List<Recipe> _recipes = [];
  List<Ingredient> _ingredients = [];

  MemoryRepository() {
    _recipeStream = _recipeStreamController.stream.asBroadcastStream(
      onListen: (subscription) {
        _recipeStreamController.sink.add(_recipes);
      },
    );

    _ingredientStream = _ingredientStreamController.stream.asBroadcastStream(
      onListen: (subscription) {
        _ingredientStreamController.sink.add(_ingredients);
      },
    );
  }

  @override
  Stream<List<Recipe>> watchAllRecipes() {
    return _recipeStream;
  }

  @override
  Stream<List<Ingredient>> watchAllIngredients() {
    return _ingredientStream;
  }

  @override
  Future<int> insertRecipe(Recipe recipe) async {
    if (!_recipes.contains(recipe)) {
      _recipes.add(recipe);
      _recipeStreamController.sink.add(_recipes);

      // Insert ingredients associated with the recipe
      for (var ingredient in recipe.ingredients) {
        insertIngredient(ingredient);
      }
      return 1;
    }
    return 0;
  }

  @override
  Future<int> insertIngredient(Ingredient ingredient) async {
    _ingredients.add(ingredient);
    _ingredientStreamController.sink.add(_ingredients);
    return 1;
  }

  void dispose() {
    _recipeStreamController.close();
    _ingredientStreamController.close();
  }
}
