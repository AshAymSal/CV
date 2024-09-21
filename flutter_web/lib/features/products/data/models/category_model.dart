// lib/data/models/category_model.dart

import '../../domain/entities/category.dart';

class CategoryModel extends category {
  const CategoryModel({required String name}) : super(name: name);

  factory CategoryModel.fromJson(String json) {
    return CategoryModel(name: json);
  }
}
