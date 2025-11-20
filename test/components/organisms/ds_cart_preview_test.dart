import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/src/components/molecules/ds_price_summary.dart';
import 'package:pragma_design_system/src/components/organisms/ds_cart_preview.dart';

/// Casos de prueba para `DSCartPreview`.
void main() {
  group('DSCartPreview', () {
    testWidgets('debería omitir el envío cuando showShipping es falso', (
      WidgetTester tester,
    ) async {
      // Arrange
      const Widget widget = DSCartPreview(
        itemCount: 2,
        subtotal: 10000,
        shipping: 5000,
        total: 15000,
        showShipping: false,
        showBtnNest: true,
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));
      final DSPriceSummary summary = tester.widget(
        find.byKey(const ValueKey<String>('dsCartPreviewPriceSummary')),
      );

      // Assert
      expect(summary.shipping, 0);
    });

    testWidgets('debería invocar la acción de checkout', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool checkoutInvocado = false;
      final Widget widget = DSCartPreview(
        itemCount: 1,
        subtotal: 20000,
        shipping: 0,
        total: 20000,
        onCheckout: () => checkoutInvocado = true,
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));
      await tester.tap(
        find.byKey(const ValueKey<String>('dsCartPreviewCheckoutButton')),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(checkoutInvocado, isTrue);
    });

    testWidgets('debería ejecutar el flujo de ver carrito', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool viewCart = false;
      final Widget widget = DSCartPreview(
        itemCount: 2,
        subtotal: 30000,
        shipping: 2000,
        total: 32000,
        onViewCart: () => viewCart = true,
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));
      await tester.tap(find.byKey(const ValueKey<String>('dsCartPreviewViewCartButton')));
      await tester.pumpAndSettle();

      // Assert
      expect(viewCart, isTrue);
    });
  });
}

/// Envuelve el organismo dentro de un `MaterialApp`.
Widget _buildTestable(Widget child) {
  return MaterialApp(
    home: Scaffold(body: Center(child: SingleChildScrollView(child: child))),
  );
}
