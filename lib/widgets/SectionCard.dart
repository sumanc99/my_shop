// lib/widgets/SectionCard.dart
import 'package:flutter/material.dart';

class Sectioncard extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const Sectioncard({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector( 
      onTap: onTap,
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 100.0,
                color: Colors.black54,
              ),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}