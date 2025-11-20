import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/src/components/templates/ds_cart_template.dart';

import '../../helpers/widget_test_utils.dart';

/// Pruebas para `DSCartTemplate`.
void main() {
  group('DSCartTemplate', () {
    testWidgets('debería mostrar el estado vacío cuando no hay productos', (
      WidgetTester tester,
    ) async {
      // Arrange
      const Widget widget = DSCartTemplate(
        config: {
          'products': <Map<String, dynamic>>[],
          'summary': {'subtotal': 0.0, 'shipping': 0.0, 'discount': 0.0, 'total': 0.0},
        },
        onRemove: _noopWithId,
        onAdd: _noopWithId,
        onDelete: _noopWithId,
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));

      // Assert
      expect(find.byKey(const ValueKey<String>('dsCartTemplateEmptyCenter')), findsOneWidget);
    });

    testWidgets('debería propagar acciones de ítems y checkout', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool added = false;
      bool removed = false;
      bool deleted = false;
      bool checkout = false;
      final Widget widget = DSCartTemplate(
        config: {
          'products': [
            {
              'id': 1,
              'title': 'Producto',
              'price': '\$10',
              'imageUrl': 'https://example.com/img.png',
              'amount': 1,
            },
          ],
          'summary': {'subtotal': 10.0, 'shipping': 0.0, 'discount': 0.0, 'total': 10.0},
          'onCheckout': () => checkout = true,
        },
        onRemove: (_) => removed = true,
        onAdd: (_) => added = true,
        onDelete: (_) => deleted = true,
      );

      // Act
      await runWithNetworkImageMocks(() async {
        await tester.pumpWidget(_buildTestable(widget));
        await tester.pump();
      });
      await tester.tap(find.byKey(const ValueKey<String>('dsCartTemplateItemIncrease_1')));
      await tester.tap(find.byKey(const ValueKey<String>('dsCartTemplateItemDecrease_1')));
      await tester.tap(find.byKey(const ValueKey<String>('dsCartTemplateItemDelete_1')));
      await tester.tap(find.byKey(const ValueKey<String>('dsCartTemplateCheckoutButton')));
      await tester.pumpAndSettle();

      // Assert
      expect(added, isTrue);
      expect(removed, isTrue);
      expect(deleted, isTrue);
      expect(checkout, isTrue);
    });
  });
}

Widget _buildTestable(Widget child) {
  return MaterialApp(home: child);
}

void _noopWithId(int _) {}
