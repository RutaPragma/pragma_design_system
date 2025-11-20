import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/src/components/molecules/ds_product_card.dart';

import '../../helpers/widget_test_utils.dart';

/// Validaciones para la molécula `DSProductCard`.
void main() {
  group('DSProductCard', () {
    testWidgets('debería mostrar título, precio y badge correspondiente', (
      WidgetTester tester,
    ) async {
      // Arrange
      final Widget widget = DSProductCard(
        imageUrl: 'https://example.com/product.png',
        title: 'Sneakers',
        price: '\$99.99',
        badgeText: 'Nuevo',
      );

      // Act
      await runWithNetworkImageMocks(() async {
        await tester.pumpWidget(_buildTestable(widget));
        await tester.pump();
      });

      // Assert
      expect(find.text('Sneakers'), findsOneWidget);
      expect(find.text('\$99.99'), findsOneWidget);
      expect(find.byKey(const ValueKey<String>('dsProductCardBadge')), findsOneWidget);
    });

    testWidgets('debería llamar al callback de agregar al presionar el botón', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool agregado = false;
      final Widget widget = DSProductCard(
        imageUrl: 'https://example.com/product.png',
        title: 'Sneakers',
        price: '\$99.99',
        onAddPressed: () => agregado = true,
      );

      // Act
      await runWithNetworkImageMocks(() async {
        await tester.pumpWidget(_buildTestable(widget));
        await tester.pump();
      });
      await tester.tap(find.byKey(const ValueKey<String>('dsProductCardButton')));
      await tester.pumpAndSettle();

      // Assert
      expect(agregado, isTrue);
    });

    testWidgets('debería propagar el onTap general cuando se toca la tarjeta', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool tarjetaTocada = false;
      final Widget widget = DSProductCard(
        imageUrl: 'https://example.com/product.png',
        title: 'Sneakers',
        price: '\$99.99',
        onTapPressed: () => tarjetaTocada = true,
      );

      // Act
      await runWithNetworkImageMocks(() async {
        await tester.pumpWidget(_buildTestable(widget));
        await tester.pump();
      });
      final Finder cardFinder =
          find.byKey(const ValueKey<String>('dsProductCardTapArea'));
      final GestureDetector gesture = tester.widget(cardFinder);
      gesture.onTap?.call();

      // Assert
      expect(tarjetaTocada, isTrue);
    });
  });
}

/// Construye el árbol mínimo requerido para la tarjeta.
Widget _buildTestable(Widget child) {
  return MaterialApp(
    home: Scaffold(body: Center(child: child)),
  );
}
