import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/unit_catalog.dart';
import '../services/converter_service.dart';
import '../widgets/section_label.dart';
import '../widgets/unit_dropdown.dart';

/// Main screen: value field, From/To unit pickers, Convert, and result.
///
/// Layout is a centered vertical stack that mirrors the Measures Converter
/// screenshot (Material 2 underlines, grey Convert button, grey result line).
class ConverterScreen extends StatefulWidget {
  const ConverterScreen({
    super.key,
    this.converter = const ConverterService(),
  });

  final ConverterService converter;

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  /// Defaults match the screenshot so the first conversion is meters → feet.
  String _fromUnit = UnitCatalog.meters.name;
  String _toUnit = UnitCatalog.feet.name;
  String _resultMessage = '';

  final TextEditingController _valueController = TextEditingController();

  @override
  void dispose() {
    _valueController.dispose();
    super.dispose();
  }

  void _convert() {
    final raw = _valueController.text.trim();
    if (raw.isEmpty) {
      setState(() => _resultMessage = 'Please enter a value.');
      return;
    }

    final value = double.tryParse(raw);
    if (value == null) {
      setState(() => _resultMessage = 'Please enter a valid number.');
      return;
    }

    final from = UnitCatalog.byName(_fromUnit);
    final to = UnitCatalog.byName(_toUnit);

    setState(() {
      try {
        final result = widget.converter.convert(
          value: value,
          from: from,
          to: to,
        );
        _resultMessage = widget.converter.formatResult(
          value: value,
          from: from,
          result: result,
          to: to,
        );
      } on ArgumentError catch (error) {
        _resultMessage = error.message?.toString() ?? error.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Measures Converter'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Cap width on tablets / landscape so the form stays readable.
            final horizontal = constraints.maxWidth > 520 ? 80.0 : 36.0;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontal,
                vertical: 28,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: constraints.maxWidth - horizontal * 2,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SectionLabel('Value'),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _valueController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                      ],
                      style: const TextStyle(fontSize: 16),
                      decoration: const InputDecoration(
                        isDense: true,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    const SectionLabel('From'),
                    const SizedBox(height: 4),
                    UnitDropdown(
                      value: _fromUnit,
                      units: UnitCatalog.names,
                      onChanged: (selected) {
                        if (selected == null) return;
                        setState(() => _fromUnit = selected);
                      },
                    ),
                    const SizedBox(height: 28),
                    const SectionLabel('To'),
                    const SizedBox(height: 4),
                    UnitDropdown(
                      value: _toUnit,
                      units: UnitCatalog.names,
                      onChanged: (selected) {
                        if (selected == null) return;
                        setState(() => _toUnit = selected);
                      },
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: ElevatedButton(
                        onPressed: _convert,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE0E0E0),
                          foregroundColor: Colors.blue,
                          elevation: 2,
                          shadowColor: Colors.black26,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        child: const Text('Convert'),
                      ),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      _resultMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
