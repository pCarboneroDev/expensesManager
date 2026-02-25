import 'package:expenses_manager/presentation/create_transaction/ui/widgets/date_modal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateCard extends StatelessWidget {
  final DateTime selectedDate;
  final void Function(DateTime) updateDate;

  const DateCard({super.key, required this.selectedDate, required this.updateDate});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () { 
        showModalBottomSheet(
          context: context, 
          builder: (BuildContext context) {
            return DateModal(selectedDate: selectedDate, updateDate: updateDate);
          }
        );
      }, //() => _selectDate(context),
      child: Container(
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
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.calendar_today, color: Colors.blue),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Fecha',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat('EEEE d MMMM, yyyy').format(selectedDate),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
          ],
        ),
      ),
    );
  }
}
