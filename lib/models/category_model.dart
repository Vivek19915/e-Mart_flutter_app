// To parse this JSON data, do
//    use app.quicktype to create model
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

class CategoryModel {
  List<Category> categories;

  CategoryModel({
    required this.categories,
  });

  //converting rom json to dart model
  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
  );

}

class Category {
  String name;
  List<String> subcategories;

  Category({
    required this.name,
    required this.subcategories,
  });

  //converting from json to map
  factory Category.fromJson(Map<String, dynamic> json) => Category(
    name: json["name"],
    subcategories: List<String>.from(json["subcategories"].map((x) => x)),
  );

}
