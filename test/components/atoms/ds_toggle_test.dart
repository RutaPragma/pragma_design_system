import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/src/components/atoms/ds_toggle.dart';

/// Suite de pruebas para el átomo `DSToggle`.
void main() {
  group('DSToggle', () {
    testWidgets('should render the optional label when it is requested', (
      WidgetTester tester,
    ) async {
      // Arrange
      const Widget widget = DSToggle(
        value: true,
        label: 'Notificaciones',
        showLabel: true,
        onChanged: _noop,
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));

      // Assert
      expect(
        find.byKey(const ValueKey<String>('dsToggleLabel')),
        findsOneWidget,
      );
      expect(find.text('Notificaciones'), findsOneWidget);
    });

    testWidgets('should notify interactions through the gesture detector', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool wasTriggered = false;
      final Widget widget = DSToggle(
        value: true,
        onChanged: (bool value) => wasTriggered = value,
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));
      await tester.tap(find.byKey(const ValueKey<String>('dsToggleGesture')));
      await tester.pumpAndSettle();

      // Assert
      expect(wasTriggered, isTrue);
    });
  });
}

/// Crea la envoltura mínima requerida para renderizar el toggle.
Widget _buildTestable(Widget child) {
  return MaterialApp(
    home: Scaffold(body: Center(child: child)),
  );
}

/// Acción nula usada por los escenarios que no requieren callback.
void _noop(bool _) {}
