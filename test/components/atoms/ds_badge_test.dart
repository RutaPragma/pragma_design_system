import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/src/components/atoms/ds_badge.dart';

/// Casos de prueba del átomo `DSBadge`.
void main() {
  group('DSBadge', () {
    testWidgets('debería mostrar el texto configurado', (
      WidgetTester tester,
    ) async {
      // Arrange
      const Widget widget = DSBadge(label: 'Nuevo');

      // Act
      await tester.pumpWidget(_buildTestable(widget));

      // Assert
      expect(find.text('Nuevo'), findsOneWidget);
    });

    testWidgets('debería invocar el callback al presionarlo', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool fuePresionado = false;
      final Widget widget = DSBadge(
        label: 'Stock',
        onTap: () => fuePresionado = true,
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));
      await tester.tap(find.byType(DSBadge));
      await tester.pumpAndSettle();

      // Assert
      expect(fuePresionado, isTrue);
    });

    testWidgets('debería renderizar un CustomPaint cuando es medalla', (
      WidgetTester tester,
    ) async {
      // Arrange
      const Widget widget = DSBadge(
        key: ValueKey<String>('badgeMedalla'),
        label: 'TOP',
        isMedal: true,
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));

      // Assert
      expect(
        find.descendant(
          of: find.byKey(const ValueKey<String>('badgeMedalla')),
          matching: find.byType(CustomPaint),
        ),
        findsOneWidget,
      );
    });
  });
}

/// Envuelve el badge en un árbol mínimo de Material.
Widget _buildTestable(Widget child) {
  return MaterialApp(
    home: Scaffold(body: Center(child: child)),
  );
}
