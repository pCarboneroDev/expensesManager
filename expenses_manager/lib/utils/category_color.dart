import 'package:flutter/material.dart';

Color getCategoryColor(String category) {
  switch (category.toLowerCase()) {
    case 'food':
      return Colors.red;
    case 'clothing':
      return Colors.blueAccent;
    case 'taxes':
      return Colors.green;
    case 'salary':
      return Colors.yellow;
    case 'inversions':
      return Colors.purpleAccent;
    case 'entertaiment':
      return Colors.orangeAccent;
    case 'health':
      return Colors.greenAccent;
    case 'other':
      return Colors.blueGrey;
    default:
      return Colors.grey;
  }
}
