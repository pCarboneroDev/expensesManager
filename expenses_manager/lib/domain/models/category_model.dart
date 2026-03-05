import 'package:flutter/material.dart';

class CategoryModel {
  final int id;
  final String name;
  final IconData icon;

  const CategoryModel({required this.id, required this.name, required this.icon});

  factory CategoryModel.empty() {
    return CategoryModel(
      id: 0,
      name: "",
      icon: Icons.abc
    );
  }
}
