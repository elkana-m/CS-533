import 'package:flutter/material.dart';

/// Centered grey caption used above Value / From / To.
class SectionLabel extends StatelessWidget {
  const SectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey[600],
      ),
    );
  }
}
