import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/src/components/molecules/ds_order_summary.dart';

import '../../helpers/widget_test_utils.dart';

/// Casos de prueba para la molécula `DSOrderSummary`.
void main() {
  group('DSOrderSummary', () {
    testWidgets('debería renderizar encabezado y productos configurados', (
      WidgetTester tester,
    ) async {
      // Arrange
      final Widget widget = DSOrderSummary(
        orderId: '123',
        orderDate: '2024-05-01',
        orderStatus: 'Entregado',
        products: const <Map<String, dynamic>>[
          {
            'imageUrl': 'https://example.com/p1.png',
            'title': 'Producto A',
            'price': '29.90',
            'quantity': 2,
          },
        ],
        subtotal: '29.90',
        shipping: '0',
        total: '29.90',
        actionLabel: 'Ver',
      );

      // Act
      await runWithNetworkImageMocks(() async {
        await tester.pumpWidget(_buildTestable(widget));
        await tester.pump();
      });

      // Assert
      expect(find.text('Orden #123'), findsOneWidget);
      expect(find.text('2024-05-01'), findsOneWidget);
      expect(find.textContaining('Producto A'), findsOneWidget);
      expect(
        find.byKey(const ValueKey<String>('dsOrderSummaryProductRow_0')),
        findsOneWidget,
      );
    });

    testWidgets('debería ejecutar la acción principal al presionar el botón', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool accionEjecutada = false;
      final Widget widget = DSOrderSummary(
        orderId: '888',
        orderDate: '2024-05-05',
        orderStatus: 'Pendiente',
        products: const <Map<String, dynamic>>[],
        subtotal: '0',
        shipping: '0',
        total: '0',
        actionLabel: 'Rastrear',
        onAction: () => accionEjecutada = true,
      );

      // Act
      await runWithNetworkImageMocks(() async {
        await tester.pumpWidget(_buildTestable(widget));
        await tester.pump();
      });
      await tester.tap(
        find.byKey(const ValueKey<String>('dsOrderSummaryActionButton')),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(accionEjecutada, isTrue);
    });

    testWidgets('debería mostrar un placeholder cuando la imagen falla', (
      WidgetTester tester,
    ) async {
      // Arrange
      final Widget widget = DSOrderSummary(
        orderId: '456',
        orderDate: '2024-06-01',
        orderStatus: 'Pendiente',
        products: const <Map<String, dynamic>>[
          {
            'imageUrl': 'https://example.com/does_not_exist.png',
            'title': 'Sin imagen',
            'price': '10.00',
            'quantity': 1,
          },
        ],
        subtotal: '10.00',
        shipping: '0',
        total: '10.00',
        actionLabel: 'Revisar',
      );

      // Act
      await runWithNetworkImageMocks(() async {
        await tester.pumpWidget(_buildTestable(widget));
        await tester.pump();
      });

      // Assert
      expect(
        find.byKey(const ValueKey<String>('dsOrderSummaryProductImageError_0')),
        findsOneWidget,
      );
    });
  });
}

/// Envoltura mínima para renderizar la molécula.
Widget _buildTestable(Widget child) {
  return MaterialApp(
    home: Scaffold(body: Center(child: child)),
  );
}
