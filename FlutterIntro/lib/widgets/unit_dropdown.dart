import 'package:flutter/material.dart';

/// Full-width dropdown used for the From and To unit pickers.
///
/// Styled to match the screenshot: blue selected text, blue underline,
/// grey trailing arrow.
class UnitDropdown extends StatelessWidget {
  const UnitDropdown({
    super.key,
    required this.value,
    required this.units,
    required this.onChanged,
  });

  final String? value;
  final List<String> units;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      value: value,
      icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
      style: const TextStyle(
        color: Colors.blue,
        fontSize: 16,
      ),
      underline: Container(
        height: 1.0,
        color: Colors.blue,
      ),
      items: [
        for (final unit in units)
          DropdownMenuItem<String>(
            value: unit,
            child: Text(unit),
          ),
      ],
      onChanged: onChanged,
    );
  }
}
