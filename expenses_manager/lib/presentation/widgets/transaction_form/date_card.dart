import 'package:expenses_manager/presentation/widgets/transaction_form/date_modal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateCard extends StatelessWidget {
  final DateTime selectedDate;
  final void Function(DateTime) updateDate;

  const DateCard({super.key, required this.selectedDate, required this.updateDate});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      color: ColorScheme.of(context).surfaceContainer,
      shadowColor: ColorScheme.of(context).shadow,
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () { 
          showModalBottomSheet(
            context: context, 
            builder: (BuildContext context) {
              return DateModal(selectedDate: selectedDate, updateDate: updateDate);
            }
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: ColorScheme.of(context).primary.withAlpha(30),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.calendar_today, color: Colors.amber),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Date',
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
      ),
    );
  }
}


// class DateCard extends StatelessWidget {
//   final DateTime selectedDate;
//   final void Function(DateTime) updateDate;

//   const DateCard({
//     super.key,
//     required this.selectedDate,
//     required this.updateDate,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(16),
//       onTap: () {},
//       child: Ink(
//         decoration: BoxDecoration(
//           color: ColorScheme.of(context).surfaceContainer,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Container(
//           padding: const EdgeInsets.all(20),
//           child: Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: Colors.blue.withAlpha(40),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: const Icon(Icons.calendar_today, color: Colors.blue),
//               ),
//               const SizedBox(width: 16),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Fecha',
//                     style: TextStyle(fontSize: 14, color: Colors.grey),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     DateFormat('EEEE d MMMM, yyyy').format(selectedDate),
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//               const Spacer(),
//               const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }