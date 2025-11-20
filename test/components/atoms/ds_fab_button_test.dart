import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/src/components/atoms/buttons/ds_fab_button.dart';

/// Pruebas del átomo `DSFabButton`.
void main() {
  group('DSFabButton', () {
    testWidgets('debería renderizar el ícono proporcionado', (
      WidgetTester tester,
    ) async {
      // Arrange
      const Widget widget = DSFabButton(
        icon: Icons.chat,
        onPressed: _noop,
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));

      // Assert
      expect(find.byIcon(Icons.chat), findsOneWidget);
    });

    testWidgets('debería ejecutar onPressed al presionar el botón', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool fueInvocado = false;
      final Widget widget = DSFabButton(
        icon: Icons.add,
        onPressed: () => fueInvocado = true,
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));
      await tester.tap(find.byKey(const ValueKey<String>('dsFabFloatingButton')));
      await tester.pumpAndSettle();

      // Assert
      expect(fueInvocado, isTrue);
    });
  });
}

/// Devuelve la envoltura mínima de MaterialApp para el FAB.
Widget _buildTestable(Widget child) {
  return MaterialApp(
    home: Scaffold(body: Center(child: child)),
  );
}

void _noop() {}
