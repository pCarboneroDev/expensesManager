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
    case 'entertaiment':
      return Icons.sports_esports;
    case 'health':
      return Icons.local_hospital;
    case 'other':
      return Icons.more_horiz;
    default:
      return Icons.category;
  }
}


// Icon getCategoryIcon(String name) {
//   switch (name.toLowerCase()) {
//     case 'food':
//       return Icon(Icons.restaurant_menu, color: const Color.fromARGB(255, 33, 163, 37));
//     case 'clothing':
//       return Icon(Icons.shopping_bag, color: const Color.fromARGB(255, 33, 148, 163));
//     case 'taxes':
//       return Icon(Icons.request_quote, color: const Color.fromARGB(255, 163, 161, 33));
//     case 'salary':
//       return Icon(Icons.monetization_on, color: const Color.fromARGB(255, 255, 196, 0));
//     case 'inversions':
//       return Icon(Icons.show_chart, color: const Color.fromARGB(255, 255, 168, 38));
//     case 'entertaiment':
//       return Icon(Icons.sports_esports, color: const Color.fromARGB(255, 252, 92, 0));
//     case 'health':
//       return Icon(Icons.local_hospital, color: const Color.fromARGB(255, 163, 33, 33));
//     case 'other':
//       return Icon(Icons.more_horiz, color: const Color.fromARGB(255, 33, 126, 163));
//     default:
//       return Icon(Icons.category, color: const Color.fromARGB(255, 168, 168, 168));
//   }
// }