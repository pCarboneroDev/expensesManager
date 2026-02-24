import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  final double monthIncome;
  final double monthExpenses;

  const BalanceCard({required this.monthIncome, required this.monthExpenses});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      // margin: EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Color.fromARGB(255, 243, 237, 247),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(31, 0, 0, 0),
            offset: Offset(0, 3),
            blurRadius: BorderSide.strokeAlignOutside,
            spreadRadius: BorderSide.strokeAlignOutside,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${monthIncome - monthExpenses}€',
            style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '-$monthExpenses',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Text(
                '+$monthIncome€',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Spacer(), Text('Details'), Icon(Icons.arrow_right)],
          ),
        ],
      ),
    );
  }
}