import '../models/measure_unit.dart';

/// All units available in the converter.
///
/// Add a new unit here — the dropdowns and conversion math pick it up
/// automatically. Keep [MeasureUnit.toBaseFactor] in SI (meters / kilograms).
class UnitCatalog {
  UnitCatalog._();

  // --- Length (base: meters) -------------------------------------------------

  static const meters = MeasureUnit(
    name: 'meters',
    category: MeasureCategory.length,
    system: MeasureSystem.metric,
    toBaseFactor: 1.0,
  );

  static const kilometers = MeasureUnit(
    name: 'kilometers',
    category: MeasureCategory.length,
    system: MeasureSystem.metric,
    toBaseFactor: 1000.0,
  );

  static const centimeters = MeasureUnit(
    name: 'centimeters',
    category: MeasureCategory.length,
    system: MeasureSystem.metric,
    toBaseFactor: 0.01,
  );

  static const miles = MeasureUnit(
    name: 'miles',
    category: MeasureCategory.length,
    system: MeasureSystem.imperial,
    toBaseFactor: 1609.344,
  );

  static const yards = MeasureUnit(
    name: 'yards',
    category: MeasureCategory.length,
    system: MeasureSystem.imperial,
    toBaseFactor: 0.9144,
  );

  static const feet = MeasureUnit(
    name: 'feet',
    category: MeasureCategory.length,
    system: MeasureSystem.imperial,
    toBaseFactor: 0.3048,
  );

  static const inches = MeasureUnit(
    name: 'inches',
    category: MeasureCategory.length,
    system: MeasureSystem.imperial,
    toBaseFactor: 0.0254,
  );

  // --- Mass (base: kilograms) ------------------------------------------------

  static const grams = MeasureUnit(
    name: 'grams',
    category: MeasureCategory.mass,
    system: MeasureSystem.metric,
    toBaseFactor: 0.001,
  );

  static const kilograms = MeasureUnit(
    name: 'kilograms',
    category: MeasureCategory.mass,
    system: MeasureSystem.metric,
    toBaseFactor: 1.0,
  );

  static const pounds = MeasureUnit(
    name: 'pounds',
    category: MeasureCategory.mass,
    system: MeasureSystem.imperial,
    toBaseFactor: 0.45359237,
  );

  static const ounces = MeasureUnit(
    name: 'ounces',
    category: MeasureCategory.mass,
    system: MeasureSystem.imperial,
    toBaseFactor: 0.028349523125,
  );

  /// Units in display order (metric length, imperial length, metric mass, imperial mass).
  static const List<MeasureUnit> all = [
    meters,
    kilometers,
    centimeters,
    grams,
    kilograms,
    feet,
    miles,
    yards,
    inches,
    pounds,
    ounces,
  ];

  static List<String> get names => [for (final unit in all) unit.name];

  static MeasureUnit byName(String name) =>
      all.firstWhere((unit) => unit.name == name);
}
