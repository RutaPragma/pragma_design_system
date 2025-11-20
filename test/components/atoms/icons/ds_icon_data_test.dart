import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/src/components/atoms/icons/ds_icon_data.dart';

import '../../../helpers/widget_test_utils.dart';

/// Pruebas unitarias para `DSIconData`.
void main() {
  group('DSIconData', () {
    test('debería construir la ruta de svg correctamente', () {
      // Arrange
      const DSIconData iconData = DSIconData('cart');

      // Act
      final String path = iconData.path;

      // Assert
      expect(path, 'assets/icons/svg/cart.svg');
    });

    test('debería generar IconData válido desde el nombre', () {
      // Arrange
      const DSIconData customIcon = DSIconData('user');

      // Act
      final IconData icon = customIcon.toIconData();

      // Assert
      expect(icon.fontFamily, 'DSCustomIcons');
      expect(icon.matchTextDirection, isFalse);
    });

    testWidgets('debería renderizar un SvgPicture usando toSvg', (
      WidgetTester tester,
    ) async {
      // Arrange
      registerMockAssets();
      const DSIconData customIcon = DSIconData('sample');

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: customIcon.toSvg(size: 24, color: Colors.red),
          ),
        ),
      );

      // Assert
      expect(find.byType(SvgPicture), findsOneWidget);
    });

    test('fromSvg debería crear IconData directamente', () {
      // Act
      final IconData icon = DSIconData.fromSvg('notification');

      // Assert
      expect(icon, isA<IconData>());
      expect(icon.fontFamily, 'DSCustomIcons');
    });
  });
}
