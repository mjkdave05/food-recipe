import 'dart:convert';
import 'package:food_recipe/models/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeApi {
  static Future<List<Recipe>> getRecipe() async {
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list', {
      'limit': '24',
      'start': '0',
    });

    final response = await http.get(uri, headers: {
      'x-rapidapi-key': '56773e54edmshca57e3db7bb1b04p1f3144jsnc7f3c66817d2',
      'x-rapidapi-host': 'yummly2.p.rapidapi.com',
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List _temp = [];

      for (var i in data['feed']) {
        _temp.add(i['content']['details']);
      }

      return Recipe.recipesFromSnapshot(_temp);
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}
