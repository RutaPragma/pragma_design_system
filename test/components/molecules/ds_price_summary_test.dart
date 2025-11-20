import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/src/components/molecules/ds_price_summary.dart';

/// Pruebas de la molécula `DSPriceSummary`.
void main() {
  group('DSPriceSummary', () {
    testWidgets('debería mostrar la fila de descuento cuando existe valor', (
      WidgetTester tester,
    ) async {
      // Arrange
      const Widget widget = DSPriceSummary(
        subtotal: 30000,
        shipping: 5000,
        discount: 2000,
        total: 33000,
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));

      // Assert
      expect(find.textContaining('Descuento'), findsOneWidget);
      expect(find.text('- \$2,000.00'), findsOneWidget);
    });

    testWidgets('debería ejecutar el botón principal cuando se presiona', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool botonPresionado = false;
      final Widget widget = DSPriceSummary(
        subtotal: 10000,
        shipping: 0,
        discount: 0,
        total: 10000,
        buttonLabel: 'Continuar',
        onButtonPressed: () => botonPresionado = true,
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));
      await tester.tap(find.byKey(const ValueKey<String>('dsPriceSummaryButton')));
      await tester.pumpAndSettle();

      // Assert
      expect(botonPresionado, isTrue);
    });

    testWidgets('debería ocultar el botón cuando showBtnNest es falso', (
      WidgetTester tester,
    ) async {
      // Arrange
      const Widget widget = DSPriceSummary(
        subtotal: 20000,
        shipping: 0,
        discount: 0,
        total: 20000,
        showBtnNest: false,
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));

      // Assert
      expect(find.byKey(const ValueKey<String>('dsPriceSummaryButton')), findsNothing);
    });
  });
}

/// Envoltura básica para renderizar el resumen de precios.
Widget _buildTestable(Widget child) {
  return MaterialApp(
    home: Scaffold(body: Center(child: child)),
  );
}
