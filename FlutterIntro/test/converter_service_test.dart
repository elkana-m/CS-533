import 'package:flutter_test/flutter_test.dart';
import 'package:measures_converter/data/unit_catalog.dart';
import 'package:measures_converter/services/converter_service.dart';

void main() {
  const converter = ConverterService();

  test('100 meters to feet matches the screenshot result', () {
    final result = converter.convert(
      value: 100,
      from: UnitCatalog.meters,
      to: UnitCatalog.feet,
    );
    final message = converter.formatResult(
      value: 100,
      from: UnitCatalog.meters,
      result: result,
      to: UnitCatalog.feet,
    );

    expect(message, '100.0 meters are 328.084 feet');
  });

  test('converts miles to kilometers', () {
    final result = converter.convert(
      value: 1,
      from: UnitCatalog.miles,
      to: UnitCatalog.kilometers,
    );
    expect(result, closeTo(1.609344, 0.000001));
  });

  test('converts kilograms to pounds', () {
    final result = converter.convert(
      value: 1,
      from: UnitCatalog.kilograms,
      to: UnitCatalog.pounds,
    );
    expect(result, closeTo(2.204622621, 0.000001));
  });

  test('rejects converting length to mass', () {
    expect(
      () => converter.convert(
        value: 10,
        from: UnitCatalog.meters,
        to: UnitCatalog.pounds,
      ),
      throwsArgumentError,
    );
  });
}
