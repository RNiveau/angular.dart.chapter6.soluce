library query_service;

import 'dart:async';
import 'dart:convert';

import 'recipe.dart';
import 'package:angular/angular.dart';

class QueryService {
  String _recipesUrl = 'recipes.json';
  String _categoriesUrl = 'categories.json';

  Future _loaded;

  Map<String, Recipe> _recipesCache;
  List<String> _categoriesCache;

  Http _http;

  QueryService(Http this._http) {
    _loaded = Future.wait([_loadRecipes(), _loadCategories()]);
  }

  Future _loadRecipes() {
    return _http.get(_recipesUrl)
      .then((HttpResponse response) {
        _recipesCache = new Map();
        for (Map recipe in response.data) {
          Recipe r = new Recipe.fromJsonMap(recipe);
          _recipesCache[r.id] = r;
        }
      });
  }

  Future _loadCategories() {
    return _http.get(_categoriesUrl)
        .then((HttpResponse response) {
          _categoriesCache = new List();
          for (String category in response.data) {
            _categoriesCache.add(category);
          }
    });
  }

  Future<Map<String, Recipe>> addRecipe(Recipe recipe) {
    _recipesCache[(_recipesCache.length + 1).toString()] = recipe;
    List list = new List();
    
    _http.put(_recipesUrl, JSON.encode(_recipesCache.values.toList(growable: false))).catchError((error) {
      print(error);
    });
  }
  
  Future<Recipe> getRecipeById(String id) {
    return _recipesCache == null
        ? _loaded.then((_) => _recipesCache[id])
        : new Future.value(_recipesCache[id]);
  }

  Future<Map<String, Recipe>> getAllRecipes() {
    return _recipesCache == null
        ? _loaded.then((_) => _recipesCache)
        : new Future.value(_recipesCache);
  }

  Future<List<String>> getAllCategories() {
    return _categoriesCache == null
        ? _loaded.then((_) => _categoriesCache)
        : new Future.value(_categoriesCache);
  }
}
