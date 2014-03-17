library add_recipe_book_controller;

import 'package:angular/angular.dart';

import 'tooltip/tooltip_directive.dart';
import 'service/recipe.dart';
import 'service/query_service.dart';

@NgController(
    selector: '[add-recipe-book]',
    publishAs: 'addCtrl')
class AddRecipeBookController {

  QueryService _queryService;
  QueryService get queryService => _queryService;

  Recipe _newRecipe;
  String _strRecipe;

  // Determine the initial load state of the app
  AddRecipeBookController(QueryService this._queryService) {
    _newRecipe = new Recipe.newRecipe();
  }

  void save() {
    _queryService.addRecipe(_newRecipe);
    _newRecipe = new Recipe.newRecipe();
  }
  
  
  Recipe get newRecipe => _newRecipe;
}