String formatDate(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = DateTime(now.year, now.month, now.day - 1);

  if (date == today) {
    return 'Hoy';
  } else if (date == yesterday) {
    return 'Ayer';
  } else {
    // Formato: "lunes, 25 de febrero"
    final weekdays = [
      'lunes',
      'martes',
      'miércoles',
      'jueves',
      'viernes',
      'sábado',
      'domingo',
    ];
    final months = [
      'enero',
      'febrero',
      'marzo',
      'abril',
      'mayo',
      'junio',
      'julio',
      'agosto',
      'septiembre',
      'octubre',
      'noviembre',
      'diciembre',
    ];

    return '${weekdays[date.weekday - 1]}, ${date.day} de ${months[date.month - 1]}';
  }
}