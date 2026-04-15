import 'dart:convert';

import 'package:expenses_manager/domain/models/category_model.dart';
import 'package:expenses_manager/utils/get_icon.dart';

class CategoryEntity {
  final int id;
  final String name;

  CategoryEntity({required this.id, required this.name});

  factory CategoryEntity.fromJson(String str) => CategoryEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryEntity.fromMap(Map<String, dynamic> json) => CategoryEntity(
    id: json["id"] ?? 0,
    name: json["name"] ?? ""
  );

  Map<String, dynamic> toMap() => {
    /* "name": name,
    "role": role,
    "date": profilePicture,
    "location": shortDescription,
    "description": description,
    "companyLogo": companyLogo*/
  };
}

extension CategoryEntityapper on CategoryEntity {
  CategoryModel toModel() {
    return CategoryModel(
      id: id, 
      name: name, 
      icon: getCategoryIcon(name)
    );
  }
}
