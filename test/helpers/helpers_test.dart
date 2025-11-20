import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/src/foundations/foundations.dart';
import 'package:pragma_design_system/src/utils/enums.dart';
import 'package:pragma_design_system/src/utils/helpers.dart';

/// Pruebas unitarias de las utilidades declaradas en `helpers.dart`.
void main() {
  group('getDSElevation', () {
    test('debería mapear las elevaciones pequeñas', () {
      expect(getDSElevation(DSSpacin.xxs), DSSpacingFoundations.xxs);
      expect(getDSElevation(DSSpacin.xl), DSSpacingFoundations.xl);
    });

    test('debería resolver la elevación extra grande', () {
      expect(getDSElevation(DSSpacin.xxl), DSSpacingFoundations.xxl);
    });
  });

  group('getDSRadius', () {
    test('debería entregar los radios parametrizados', () {
      expect(getDSRadius(DSSizeRadius.xs), DSRadiusFoundations.radiusXS);
      expect(getDSRadius(DSSizeRadius.medium), DSRadiusFoundations.radiusMD);
    });

    test('debería mapear el radio circular', () {
      expect(getDSRadius(DSSizeRadius.radiusCircular), DSRadiusFoundations.radiusCircular);
    });
  });

  group('getDsSizeIconButton', () {
    test('debería calcular los tamaños extremos', () {
      expect(getDsSizeIconButton(DSSize.xs), DSSizesFoundations.iconSizeXS * 1.2);
      expect(getDsSizeIconButton(DSSize.small), DSSizesFoundations.iconSizeSmall * 1.3);
      expect(getDsSizeIconButton(DSSize.large), DSSizesFoundations.iconSizeLarge * 1.8);
    });
  });
}
