import 'package:expenses_manager/domain/models/movement_model.dart';
import 'package:expenses_manager/utils/format_date.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MovementHome extends StatelessWidget {
  final TransactionModel movement;

  const MovementHome({required this.movement});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          formatDate(movement.date),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 15),

        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(FontAwesomeIcons.bowlFood),
                Text(movement.category.name),
                Text('${movement.amount}€'),
              ],
            ),
            Divider(),
          ],
        ),
      ],
    );
  }
}