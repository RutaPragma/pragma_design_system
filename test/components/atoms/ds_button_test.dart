import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/src/components/atoms/buttons/ds_button.dart';
import 'package:pragma_design_system/src/utils/enums.dart';

/// Suite de pruebas del átomo `DSButton`.
void main() {
  group('DSButton', () {
    testWidgets('debería mostrar etiqueta e ícono cuando se configuran', (
      WidgetTester tester,
    ) async {
      // Arrange
      const Widget widget = DSButton(
        label: 'Comprar',
        onPressed: _noop,
        icon: Icon(Icons.shopping_cart, key: ValueKey<String>('iconoCompra')),
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));

      // Assert
      expect(find.text('Comprar'), findsOneWidget);
      expect(find.byKey(const ValueKey<String>('iconoCompra')), findsOneWidget);
    });

    testWidgets('debería ejecutar onPressed cuando está habilitado', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool fuePresionado = false;
      final Widget widget = DSButton(
        label: 'Guardar',
        onPressed: () => fuePresionado = true,
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));
      await tester.tap(find.byKey(const ValueKey<String>('dsButtonElevatedButton')));
      await tester.pumpAndSettle();

      // Assert
      expect(fuePresionado, isTrue);
    });

    testWidgets('debería deshabilitar el botón cuando la variante es disabled', (
      WidgetTester tester,
    ) async {
      // Arrange
      final Widget widget = DSButton(
        label: 'Sólo lectura',
        variant: DSButtonVariant.disabled,
        onPressed: _noop,
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));
      final ElevatedButton button = tester.widget(
        find.byKey(const ValueKey<String>('dsButtonElevatedButton')),
      );

      // Assert
      expect(button.onPressed, isNull);
    });
  });
}

/// Proporciona el arbol mínimo de Material para el botón.
Widget _buildTestable(Widget child) {
  return MaterialApp(
    home: Scaffold(body: Center(child: child)),
  );
}

void _noop() {}
