import '../models/measure_unit.dart';

/// Converts a numeric value from one [MeasureUnit] to another.
///
/// Strategy: convert to the category's SI base unit, then to the target unit.
///
///     result = value * from.toBaseFactor / to.toBaseFactor
///
/// This stays accurate for any pair of units that share a [MeasureCategory].
/// Temperature (offset-based) would need a separate formula if added later.
class ConverterService {
  const ConverterService();

  /// Converts [value] from [from] into [to].
  ///
  /// Throws [ArgumentError] when the units measure different quantities
  /// (for example meters → pounds).
  double convert({
    required double value,
    required MeasureUnit from,
    required MeasureUnit to,
  }) {
    if (from.category != to.category) {
      throw ArgumentError(
        'Cannot convert ${from.name} to ${to.name}. '
        'Both units must measure the same type '
        '(length or mass).',
      );
    }

    return value * from.toBaseFactor / to.toBaseFactor;
  }

  /// User-facing sentence, matching the screenshot style:
  /// `100.0 meters are 328.084 feet`.
  String formatResult({
    required double value,
    required MeasureUnit from,
    required double result,
    required MeasureUnit to,
  }) {
    return '${_formatSource(value)} ${from.name} are ${_formatConverted(result)} ${to.name}';
  }

  /// Source values keep a decimal (Dart prints `100.0` for that double).
  String _formatSource(double value) => value.toString();

  /// Converted values use 3 decimal places, matching `328.084` feet.
  /// Whole numbers keep a single decimal so identity conversions read `100.0`.
  String _formatConverted(double value) {
    final rounded = double.parse(value.toStringAsFixed(3));
    if (rounded == rounded.roundToDouble()) {
      return rounded.toStringAsFixed(1);
    }
    return value.toStringAsFixed(3);
  }
}
