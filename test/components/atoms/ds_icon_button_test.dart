import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/src/components/atoms/buttons/ds_icon_button.dart';
import 'package:pragma_design_system/src/utils/enums.dart';

/// Pruebas del átomo `DSIconButton`.
void main() {
  group('DSIconButton', () {
    testWidgets('debería ejecutar onPressed cuando está habilitado', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool fuePresionado = false;
      final Widget widget = DSIconButton(
        icon: Icons.thumb_up,
        onPressed: () => fuePresionado = true,
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));
      await tester.tap(find.byKey(const ValueKey<String>('dsIconButtonInkWell')));
      await tester.pumpAndSettle();

      // Assert
      expect(fuePresionado, isTrue);
    });

    testWidgets('debería bloquear interacciones cuando está deshabilitado', (
      WidgetTester tester,
    ) async {
      // Arrange
      final Widget widget = DSIconButton(
        icon: Icons.thumb_up,
        variant: DSIconButtonVariant.disabled,
        onPressed: _noop,
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));
      final InkWell inkWell = tester.widget(
        find.byKey(const ValueKey<String>('dsIconButtonInkWell')),
      );

      // Assert
      expect(inkWell.onTap, isNull);
    });
  });
}

/// MaterialApp mínimo para el ícono botón.
Widget _buildTestable(Widget child) {
  return MaterialApp(
    home: Scaffold(body: Center(child: child)),
  );
}

void _noop() {}
