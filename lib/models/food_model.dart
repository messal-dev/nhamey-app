class FoodModel {
  final int id;
  final String code;
  final String name;
  final List<String> description;
  final List<String> ingredients;
  final List<String> tags;
  final String duration;
  final String thumbnail;

  FoodModel(
    this.id,
    this.code,
    this.name,
    this.description,
    this.ingredients,
    this.tags,
    this.duration,
    this.thumbnail,
  );

  factory FoodModel.fromJson(Map<dynamic, dynamic> parsedJson) {
    List<String> newDes = [];
    List<String> newIngredients = [];
    List<String> newTags = [];

    if (parsedJson['description'] != null) {
      final temp = parsedJson['description'] as List<dynamic>;
      if (temp.isNotEmpty) {
        for (var des in temp) {
          newDes.add(des.toString());
        }
      }
    }

    if (parsedJson['ingredients'] != null) {
      final temp = parsedJson['ingredients'] as List<dynamic>;
      if (temp.isNotEmpty) {
        for (var ing in temp) {
          newIngredients.add(ing.toString());
        }
      }
    }

    if (parsedJson['tags'] != null) {
      final temp = parsedJson['tags'] as List<dynamic>;
      if (temp.isNotEmpty) {
        for (var tag in temp) {
          newTags.add(tag.toString());
        }
      }
    }

    return FoodModel(
      parsedJson["id"] as int,
      parsedJson['code'] as String,
      parsedJson['name'] as String,
      newDes,
      newIngredients,
      newTags,
      parsedJson['duration'] as String,
      parsedJson['thumbnail'] as String,
    );
  }
}
