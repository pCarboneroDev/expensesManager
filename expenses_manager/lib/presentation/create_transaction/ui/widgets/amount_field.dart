import 'package:flutter/material.dart';

class AmountField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(double) updateAmount;

  const AmountField({
    super.key,
    required this.controller,
    required this.updateAmount,
  });

  @override
  Widget build(BuildContext context) {
    return // Campo de monto
    Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorScheme.of(context).surfaceContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Amount',
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
                  autofocus: false,
                  onSubmitted: (value) {
                    if (controller.text.contains(',')) {
                      controller.text = controller.text.replaceAll(',', '.');
                    }
                    final amount = double.tryParse(value) ?? 0.0;
                    updateAmount(amount);
                  },
                  onTapUpOutside: (event) {
                    if (controller.text.contains(',')) {
                      controller.text = controller.text.replaceAll(',', '.');
                    }
                    final amount = double.tryParse(controller.text) ?? 0.0;
                    updateAmount(amount);
                    FocusScope.of(context).unfocus();
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
