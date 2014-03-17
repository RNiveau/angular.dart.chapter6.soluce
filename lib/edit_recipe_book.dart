library edit_recipe_book_controller;

import 'package:angular/angular.dart';

import 'tooltip/tooltip_directive.dart';
import 'service/recipe.dart';
import 'service/query_service.dart';

@NgController(
    selector: '[edit-recipe-book]',
    publishAs: 'editCtrl')
class EditRecipeBookController {

  static const String LOADING_MESSAGE = "Loading recipe book...";
  static const String ERROR_MESSAGE = """Sorry! The cook stepped out of the 
kitchen and took the recipe book with him!""";

  QueryService _queryService;
  QueryService get queryService => _queryService;

  Recipe _selectedRecipe;
  String _strRecipe;

  // Determine the initial load state of the app
  EditRecipeBookController(QueryService this._queryService, RouteProvider routeProvider) {
    String recipeId = routeProvider.parameters['recipeId'];
    _queryService.getRecipeById(recipeId).then((recipe) => _selectedRecipe = recipe);
  }

  void save() {
    
  }
  
  
  Recipe get selectedRecipe => _selectedRecipe;
}