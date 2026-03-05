import 'package:flutter/material.dart';

class QuantityField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(double) updateAmount;

  const QuantityField({super.key, required this.controller, required this.updateAmount});

  @override
  Widget build(BuildContext context) {
    return // Campo de monto
    Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quantity',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '\$',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: controller,
                   onChanged: (value) {
                    final amount = double.tryParse(value) ?? 0.0;
                    updateAmount(amount);
                  },
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    hintText: '0.00',
                    hintStyle: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade300,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
