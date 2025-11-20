import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/src/components/molecules/ds_payment_button.dart';

/// Escenarios de prueba del `DSPaymentButton`.
void main() {
  group('DSPaymentButton', () {
    testWidgets('debería mostrar logo, etiqueta e ícono final', (
      WidgetTester tester,
    ) async {
      // Arrange
      final Widget widget = DSPaymentButton(
        label: 'Pagar con Visa',
        logo: const Icon(Icons.payment),
        trailingIcon: Icons.chevron_right,
        onPressed: () {},
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));

      // Assert
      expect(find.text('Pagar con Visa'), findsOneWidget);
      expect(find.byIcon(Icons.payment), findsOneWidget);
      expect(
        find.byKey(const ValueKey<String>('dsPaymentButtonTrailingIcon')),
        findsOneWidget,
      );
    });

    testWidgets('debería bloquear la interacción cuando está deshabilitado', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool fueInvocado = false;
      final Widget widget = DSPaymentButton(
        label: 'PayPal',
        enabled: false,
        onPressed: () => fueInvocado = true,
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));
      final InkWell inkWell = tester.widget(
        find.byKey(const ValueKey<String>('dsPaymentButtonInkWell')),
      );

      // Assert
      expect(inkWell.onTap, isNull);
      expect(fueInvocado, isFalse);
    });

    testWidgets('debería ejecutar onPressed cuando está habilitado', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool fueInvocado = false;
      final Widget widget = DSPaymentButton(
        label: 'Mastercard',
        onPressed: () => fueInvocado = true,
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));
      await tester.tap(find.byKey(const ValueKey<String>('dsPaymentButtonInkWell')));
      await tester.pumpAndSettle();

      // Assert
      expect(fueInvocado, isTrue);
    });
  });
}

/// Crea la envoltura mínima para el botón de pago.
Widget _buildTestable(Widget child) {
  return MaterialApp(
    home: Scaffold(body: Center(child: child)),
  );
}
