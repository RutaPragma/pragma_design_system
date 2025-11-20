import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/src/components/molecules/ds_icon_counter.dart';

/// Suite con los escenarios relevantes del `DSIconCounter`.
void main() {
  group('DSIconCounter', () {
    testWidgets('debería ocultar el badge cuando el contador es cero', (
      WidgetTester tester,
    ) async {
      // Arrange
      const Widget widget = DSIconCounter(
        icon: Icons.shopping_cart_outlined,
        count: 0,
        onTap: _noop,
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));

      // Assert
      expect(
        find.byKey(const ValueKey<String>('dsIconCounterBadge')),
        findsNothing,
      );
    });

    testWidgets('debería limitar la visualización a 99+ cuando excede', (
      WidgetTester tester,
    ) async {
      // Arrange
      const Widget widget = DSIconCounter(
        icon: Icons.notifications_outlined,
        count: 150,
        onTap: _noop,
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));

      // Assert
      expect(find.text('99+'), findsOneWidget);
    });

    testWidgets('debería propagar los taps al callback asignado', (
      WidgetTester tester,
    ) async {
      // Arrange
      int tapCount = 0;
      final Widget widget = DSIconCounter(
        icon: Icons.favorite_border,
        count: 5,
        onTap: () => tapCount++,
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));
      await tester.tap(
        find.byKey(const ValueKey<String>('dsIconCounterInkWell')),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(tapCount, 1);
    });
  });
}

/// Genera la envoltura necesaria para las pruebas de widgets.
Widget _buildTestable(Widget child) {
  return MaterialApp(
    home: Scaffold(body: Center(child: child)),
  );
}

/// Callback sin implementación usado en escenarios pasivos.
void _noop() {}
