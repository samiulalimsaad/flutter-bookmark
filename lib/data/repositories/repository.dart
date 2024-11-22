import 'dart:async';

import 'package:bookmark_lab/models/ingredient.dart';
import 'package:bookmark_lab/models/recipe.dart';



abstract class Repository {
  Stream<List<Recipe>> watchAllRecipes();
  Stream<List<Ingredient>> watchAllIngredients();
  Future<int> insertRecipe(Recipe recipe);
  Future<int> insertIngredient(Ingredient ingredient);
  // Add other repository methods as needed.
}
