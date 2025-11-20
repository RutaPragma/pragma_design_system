import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/src/components/templates/ds_checkout_template.dart';

import '../../helpers/widget_test_utils.dart';

/// Validaciones para `DSCheckoutTemplate`.
void main() {
  group('DSCheckoutTemplate', () {
    testWidgets('debería completar el checkout cuando hay datos válidos', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.binding.setSurfaceSize(const Size(1200, 1800));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      Map<String, dynamic>? checkoutPayload;
      bool addressCaptured = false;
      final Map<String, dynamic> config = {
        'title': 'Checkout',
        'itemsCar': 1,
        'alertMessage': {
          'confirmError': 'Faltan datos',
          'selectPayment': 'Selecciona pago',
        },
        'orderSummary': {
          'orderId': '001',
          'orderDate': '2024-05-01',
          'orderStatus': 'Pendiente',
          'products': [
            {
              'imageUrl': 'https://example.com/img.png',
              'title': 'Item',
              'price': '10.0',
              'quantity': 1,
            },
          ],
          'subtotal': '10.0',
          'shipping': '0.0',
          'total': '10.0',
          'actionLabel': 'Ver',
        },
        'shippingConfig': {
          'fields': {
            'name': {'label': 'Nombre', 'hint': 'Tu nombre'},
          },
          'shippingMethods': [
            {'label': 'Express', 'subtitle': '1 día'},
          ],
        },
        'paymentConfig': {
          'methods': [
            {'label': 'T', 'iconPath': 'visa.png'},
          ],
        },
        'buttonLabel': 'Confirmar',
        'onAddressComplete': (_) => addressCaptured = true,
        'onCheckoutComplete': (data) => checkoutPayload = data,
      };

      final Widget widget = DSCheckoutTemplate(config: config);

      // Act
      await runWithNetworkImageMocks(() async {
        await tester.pumpWidget(
          wrapWithFakeAssetBundle(
            Center(child: SizedBox(width: 1200, child: widget)),
          ),
        );
        await tester.pump();
      });

      final Finder nameField = find.byKey(
        const ValueKey<String>('dsShippingFormField_name'),
      );
      await tester.ensureVisible(nameField);
      await tester.enterText(nameField, 'Carlos');

      final Finder submitShipping = find.byKey(
        const ValueKey<String>('dsShippingFormSubmitButton'),
      );
      await tester.ensureVisible(submitShipping);
      await tester.tap(submitShipping, warnIfMissed: false);
      await tester.pumpAndSettle();

      final Finder confirmButton = find.byKey(
        const ValueKey<String>('dsCheckoutTemplateConfirmButton'),
      );
      await tester.ensureVisible(confirmButton);
      await tester.tap(confirmButton, warnIfMissed: false);
      await tester.pumpAndSettle();

      // Assert
      expect(addressCaptured, isTrue);
      expect(checkoutPayload, isNotNull);
      expect(checkoutPayload?['shipping']?['name'], 'Carlos');
    });
  });
  testWidgets('debería mostrar mensajes cuando faltan datos', (
    WidgetTester tester,
  ) async {
    // Arrange
    await tester.binding.setSurfaceSize(const Size(1200, 1800));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final Map<String, dynamic> config = {
      'title': 'Checkout',
      'itemsCar': 0,
      'orderSummary': {
        'orderId': '001',
        'orderDate': '2024-05-01',
        'orderStatus': 'Pendiente',
        'products': const <Map<String, dynamic>>[],
        'subtotal': '0',
        'shipping': '0',
        'total': '0',
        'actionLabel': 'Ver',
      },
      'shippingConfig': {
        'fields': {
          'name': {'label': 'Nombre', 'hint': 'Tu nombre'},
        },
        'shippingMethods': const <Map<String, String>>[],
      },
      'paymentConfig': {
        'methods': [
          {'label': 'T', 'iconPath': 'visa.png'},
        ],
      },
      'alertMessage': {
        'confirmError': 'Faltan datos',
        'selectPayment': 'Selecciona pago',
      },
    };
    final Widget widget = DSCheckoutTemplate(config: config);

    // Act
    await runWithNetworkImageMocks(() async {
      await tester.pumpWidget(
        wrapWithFakeAssetBundle(
          Center(child: SizedBox(width: 1200, child: widget)),
        ),
      );
      await tester.pump();
    });

    // Tocar botón sin completar datos
    final Finder confirmButton = find.byKey(
      const ValueKey<String>('dsCheckoutTemplateConfirmButton'),
    );
    await tester.ensureVisible(confirmButton);
    await tester.tap(confirmButton, warnIfMissed: false);
    await tester.pump();

    // Assert
    expect(find.text('Faltan datos'), findsOneWidget);
  });
}
