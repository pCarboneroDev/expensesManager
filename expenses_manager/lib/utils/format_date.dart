String formatDate(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = DateTime(now.year, now.month, now.day - 1);

  if (date == today) {
    return 'Today';
  } else if (date == yesterday) {
    return 'Yesterday';
  } else {
    // Formato: "lunes, 25 de febrero"
    final weekdays = [
      'monday',
      'thursday',
      'wednesday',
      'tuesday',
      'friday',
      'saturday',
      'sunday',
    ];
    final months = [
      'january',
      'february',
      'march',
      'april',
      'may',
      'june',
      'july',
      'august',
      'september',
      'october',
      'november',
      'december',
    ];

    return '${weekdays[date.weekday - 1]}, ${date.day}, ${months[date.month - 1]}';
  }
}