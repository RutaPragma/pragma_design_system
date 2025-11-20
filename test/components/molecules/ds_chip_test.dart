import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/src/components/molecules/ds_chip.dart';

/// Agrupa las pruebas de la molécula `DSChip`.
void main() {
  group('DSChip', () {
    testWidgets('debería mostrar el ícono y la etiqueta configurada', (
      WidgetTester tester,
    ) async {
      // Arrange
      const Widget widget = DSChip(label: 'Flutter', icon: Icons.flutter_dash);

      // Act
      await tester.pumpWidget(_buildTestable(widget));

      // Assert
      expect(find.byKey(const ValueKey<String>('dsChipIcon')), findsOneWidget);
      expect(find.byKey(const ValueKey<String>('dsChipLabel')), findsOneWidget);
      expect(find.text('Flutter'), findsOneWidget);
    });

    testWidgets('debería responder solo cuando el chip está habilitado', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool eventoHabilitado = false;
      bool eventoDeshabilitado = false;

      final Widget widget = Column(
        children: <Widget>[
          DSChip(label: 'Habilitado', onTap: () => eventoHabilitado = true),
          DSChip(
            label: 'Deshabilitado',
            enabled: false,
            onTap: () => eventoDeshabilitado = true,
          ),
        ],
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));
      final Finder gestures = find.byKey(
        const ValueKey<String>('dsChipGestureDetector'),
      );
      await tester.tap(gestures.at(0));
      await tester.tap(gestures.at(1));
      await tester.pumpAndSettle();

      // Assert
      expect(eventoHabilitado, isTrue);
      expect(eventoDeshabilitado, isFalse);
    });
  });
}

/// Crea la envoltura necesaria para renderizar la molécula.
Widget _buildTestable(Widget child) {
  return MaterialApp(
    home: Scaffold(body: Center(child: child)),
  );
}
