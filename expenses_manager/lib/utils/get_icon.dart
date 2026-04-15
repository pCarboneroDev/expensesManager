import 'package:flutter/material.dart';

IconData getCategoryIcon(String name) {
  switch (name.toLowerCase()) {
    case 'food':
      return Icons.restaurant_menu;
    case 'clothing':
      return Icons.shopping_bag;
    case 'taxes':
      return Icons.request_quote;
    case 'salary':
      return Icons.monetization_on;
    case 'inversions':
      return Icons.show_chart;
    case 'entertainment':
      return Icons.sports_esports;
    case 'health':
      return Icons.local_hospital;
    case 'other':
      return Icons.more_horiz;
    default:
      return Icons.category;
  }
}