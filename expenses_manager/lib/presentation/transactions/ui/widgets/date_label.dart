import 'package:expenses_manager/utils/format_date.dart';
import 'package:flutter/material.dart';

class DateLabel extends StatelessWidget {
  const DateLabel({required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      color: Colors.grey.shade200,
      width: double.infinity,
      child: Text(
        formatDate(date),
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}