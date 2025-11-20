import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/src/components/atoms/icons/ds_icon.dart';

/// Escenarios de verificación para el átomo `DSIcon`.
void main() {
  group('DSIcon', () {
    testWidgets('debería respetar el tamaño personalizado definido', (
      WidgetTester tester,
    ) async {
      // Arrange
      const Widget widget = DSIcon(
        icon: Icons.alarm,
        customSize: 42,
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));
      final Icon icon = tester.widget(find.byKey(const ValueKey<String>('dsIcon')));

      // Assert
      expect(icon.size, 42);
    });

    testWidgets('debería ejecutar el callback al tocar el ícono', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool fueInvocado = false;
      final Widget widget = DSIcon(
        icon: Icons.favorite,
        onPressed: () => fueInvocado = true,
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));
      await tester.tap(find.byKey(const ValueKey<String>('dsIconGesture')));
      await tester.pumpAndSettle();

      // Assert
      expect(fueInvocado, isTrue);
    });
  });
}

/// Retorna un MaterialApp mínimo para renderizar el ícono.
Widget _buildTestable(Widget child) {
  return MaterialApp(
    home: Scaffold(body: Center(child: child)),
  );
}
