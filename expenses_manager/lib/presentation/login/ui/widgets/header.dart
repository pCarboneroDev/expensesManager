import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  const Header({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 80),
        const SizedBox(height: 32),
        // Título
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 8),

        if(subtitle != null)
        Text(
          subtitle!,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
