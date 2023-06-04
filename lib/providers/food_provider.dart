import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/food_model.dart';

class FoodProvider with ChangeNotifier {
  List<FoodModel> _foods = [];
  List<FoodModel> get foods => _foods;

  List<FoodModel> _searchFoods = [];
  List<FoodModel> get searchFoods => _searchFoods;

  List<FoodModel> _randomFoods = [];
  List<FoodModel> get randomFoods => _randomFoods;

  late FoodModel? _food;
  FoodModel? get food => _food;

  final List<String> _queryTags = [];
  List<String> get queryTags => _queryTags;

  late String _query;
  String get query => _query;

  Future<void> fetch() async {
    await Future.delayed(const Duration(seconds: 3));
    final response = await rootBundle.loadString('assets/data/foods.json');

    final data = await json.decode(response) as List<dynamic>;

    if (data.isNotEmpty) {
      final List<FoodModel> newList = [];

      for (var fd in data) {
        newList.add(FoodModel.fromJson(fd));
      }

      if (newList.isNotEmpty) {
        newList.shuffle();
        _foods = newList;
        notifyListeners();
      }
    }
  }

  Future<void> fetchRandomFoods() async {
    await Future.delayed(const Duration(seconds: 1));

    _randomFoods = [..._foods];

    _randomFoods.shuffle();

    notifyListeners();
  }

  Future<void> findByCode(String code) async {
    await Future.delayed(const Duration(seconds: 1));

    if (_foods.isEmpty) {
      _food = null;
    } else {
      _food = _foods.firstWhere((ft) => ft.code == code);
    }

    notifyListeners();
  }

  List<String> get tags {
    if (_foods.isEmpty) return [];

    List<String> tags = [];
    for (var tag in _foods) {
      tags.addAll(tag.tags);
    }

    List<String> newTags = [];
    for (var tag in tags) {
      if (newTags.isNotEmpty) {
        newTags.add(tag);
      } else {
        if (!newTags.contains(tag)) {
          newTags.add(tag);
        }
      }
    }

    return newTags.toSet().toList();
  }

  void randomTags() {
    if (tags.isNotEmpty) {
      tags.shuffle();
      notifyListeners();
    }
  }

  // Searching
  void toggleQueryTag(String tag) {
    if (_queryTags.contains(tag)) {
      _queryTags.removeWhere((t) => t == tag);
    } else {
      _queryTags.add(tag);
    }

    notifyListeners();
  }

  void setQuery(String query) {
    _query = query;
    notifyListeners();
  }

  void resetQuerySearch() {
    _queryTags.clear();
    _query = '';
  }

  Future<void> filter(String query,
      {List<String> queryTags = const [], bool isRandom = false}) async {
    await Future.delayed(const Duration(seconds: 2));

    List<FoodModel> listFoods = [..._foods];
    List<FoodModel> newList = [];

    // Check with query
    if (query.isNotEmpty) {
      for (var food in listFoods) {
        final isExistTags = food.tags.contains(query);
        final isExistIngredients = food.ingredients.contains(query);

        if (isExistTags || isExistIngredients) {
          newList.add(food);
        }
      }
    }

    // Check with query tags
    if (queryTags.isNotEmpty) {
      for (var tag in queryTags) {
        for (var food in listFoods) {
          final isExistTags = food.tags.contains(tag);
          final isExistIngredients = food.ingredients.contains(tag);

          if (isExistTags || isExistIngredients) {
            newList.add(food);
          }
        }
      }
    }

    _searchFoods = [...newList.toSet().toList()];

    if (isRandom) {
      _searchFoods.shuffle();
    }

    notifyListeners();
  }
}
