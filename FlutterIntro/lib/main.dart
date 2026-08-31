import 'package:flutter/material.dart';

import 'screens/converter_screen.dart';

void main() {
  runApp(const MeasuresConverterApp());
}

/// Root widget. Material 2 is used so text fields and the AppBar match the
/// screenshot (underlines and a solid blue bar instead of Material 3 surfaces).
class MeasuresConverterApp extends StatelessWidget {
  const MeasuresConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Measures Converter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      home: const ConverterScreen(),
    );
  }
}
