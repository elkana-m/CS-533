/// Whether a unit belongs to the metric or imperial system.
enum MeasureSystem { metric, imperial }

/// Kind of quantity being measured. Conversions are only valid within a category.
enum MeasureCategory { length, mass }

/// A single unit of measure, described relative to an SI base unit.
///
/// Length units use **meters** as the base. Mass units use **kilograms**.
/// To support a new unit, add a [MeasureUnit] with the correct [toBaseFactor]
/// (how many base units equal 1 of this unit).
class MeasureUnit {
  const MeasureUnit({
    required this.name,
    required this.category,
    required this.system,
    required this.toBaseFactor,
  });

  /// Display name shown in the From/To dropdowns (e.g. `meters`, `pounds`).
  final String name;

  final MeasureCategory category;
  final MeasureSystem system;

  /// Multiply a value in this unit by [toBaseFactor] to get the SI base value.
  ///
  /// Example: 1 mile = 1609.344 meters, so miles.toBaseFactor == 1609.344.
  final double toBaseFactor;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MeasureUnit &&
          name == other.name &&
          category == other.category;

  @override
  int get hashCode => Object.hash(name, category);

  @override
  String toString() => name;
}
