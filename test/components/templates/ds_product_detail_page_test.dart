import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/src/components/templates/product_detail_page.dart';

import '../../helpers/widget_test_utils.dart';

/// Suite para `DSProductDetailPage`.
void main() {
  group('DSProductDetailPage', () {
    testWidgets('debería mostrar información y responder a las acciones', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool buyNow = false;
      bool addToCart = false;
      final Widget widget = DSProductDetailPage(
        config: {
          'itemsCar': 1,
          'product': {
            'title': 'Zapatos',
            'price': '\$99',
            'imageUrl': 'https://example.com/shoe.png',
            'description': 'Deportivos',
            'rating': 4.0,
            'badgeText': 'Nuevo',
          },
          'promoBanner': {
            'title': 'Promo',
            'imageUrl': 'https://example.com/promo.png',
          },
          'relatedProducts': [
            {
              'id': 1,
              'imageUrl': 'https://example.com/related.png',
              'title': 'Relacionado',
              'price': '\$49',
            },
          ],
          'emptyImagePath': 'empty.png',
        },
        onBuyNow: () => buyNow = true,
        onAddToCart: () => addToCart = true,
      );

      // Act
      await runWithNetworkImageMocks(() async {
        await tester.pumpWidget(wrapWithFakeAssetBundle(widget));
        await tester.pump();
      });
      await tester.tap(find.byKey(const ValueKey<String>('dsProductDetailAddToCartButton')));
      await tester.tap(find.byKey(const ValueKey<String>('dsProductDetailBuyNowButton')));
      await tester.pumpAndSettle();

      // Assert
      expect(addToCart, isTrue);
      expect(buyNow, isTrue);
      expect(find.text('Zapatos'), findsOneWidget);
      expect(find.byKey(const ValueKey<String>('dsProductDetailBadge')), findsOneWidget);
    });
  });
}
