import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/src/components/organisms/ds_product_list.dart';

import '../../helpers/widget_test_utils.dart';

/// Pruebas para el organismo `DSProductList`.
void main() {
  group('DSProductList', () {
    testWidgets('debería mostrar el estado vacío con la ilustración', (
      WidgetTester tester,
    ) async {
      // Arrange
      const Widget widget = DSProductList(
        products: <ProductItem>[],
        isGrid: true,
      );

      // Act
      await tester.pumpWidget(wrapWithFakeAssetBundle(widget));

      // Assert
      expect(find.byKey(const ValueKey<String>('dsProductListEmptyImage')), findsOneWidget);
    });

    testWidgets('debería alternar entre grid y lista y propagar onAdd', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool agregado = false;
      final List<ProductItem> items = <ProductItem>[
        const ProductItem(
          id: 1,
          imageUrl: 'https://example.com/img.png',
          title: 'Producto',
          price: '\$10',
        ),
      ];
      final Widget widget = DSProductList(
        products: items,
        isGrid: true,
        onAddPressed: (_) => agregado = true,
      );

      // Act
      await runWithNetworkImageMocks(() async {
        await tester.pumpWidget(wrapWithFakeAssetBundle(widget));
        await tester.pump();

        // Assert grid
        expect(
          find.byKey(const PageStorageKey<String>('dsProductListGridView')),
          findsOneWidget,
        );

        // Toggle vista
        await tester.tap(find.byKey(const ValueKey<String>('dsProductListToggleButton')));
        await tester.pumpAndSettle();
        expect(
          find.byKey(const PageStorageKey<String>('dsProductListListView')),
          findsOneWidget,
        );

        // Tap botón agregar
        await tester.tap(find.byKey(const ValueKey<String>('dsProductCardButton')));
        await tester.pumpAndSettle();
        await tester.pumpAndSettle();
      });

      expect(agregado, isTrue);
    });

    testWidgets('debería mostrar modo lista con rating y disparar onAdd', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool agregado = false;
      final List<ProductItem> items = <ProductItem>[
        const ProductItem(
          id: 1,
          imageUrl: 'https://example.com/item.png',
          title: 'Item',
          price: '\$15',
          rating: 4.0,
        ),
      ];
      final Widget widget = DSProductList(
        products: items,
        isGrid: false,
        showAddButton: false,
        showMenuChange: false,
        onAddPressed: (_) => agregado = true,
      );

      // Act
      await runWithNetworkImageMocks(() async {
        await tester.pumpWidget(wrapWithFakeAssetBundle(widget));
        await tester.pump();
      });

      // Assert
      expect(find.byKey(const ValueKey<String>('dsProductListToggleButton')), findsNothing);
      expect(
        find.byKey(const PageStorageKey<String>('dsProductListListView')),
        findsOneWidget,
      );
      final Finder disabledButtonFinder = find.descendant(
        of: find.byKey(const ValueKey<String>('dsProductListListCard_0')),
        matching: find.byKey(const ValueKey<String>('dsButtonElevatedButton')),
      );
      final ElevatedButton button = tester.widget(disabledButtonFinder);
      expect(button.onPressed, isNull);

      await tester.tap(find.byKey(const ValueKey<String>('dsProductListListItem_0')));
      await tester.pumpAndSettle();
      expect(agregado, isTrue);
    });

    testWidgets('debería invocar onTapPressed en modo grid', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool cardTocada = false;
      final List<ProductItem> items = <ProductItem>[
        const ProductItem(
          id: 2,
          imageUrl: 'https://example.com/card.png',
          title: 'Card',
          price: '\$20',
        ),
      ];
      final Widget widget = DSProductList(
        products: items,
        isGrid: true,
        showMenuChange: false,
        onTapPressed: (_) => cardTocada = true,
      );

      // Act
      await runWithNetworkImageMocks(() async {
        await tester.pumpWidget(wrapWithFakeAssetBundle(widget));
        await tester.pump();
      });

      // Assert
      await tester.tap(find.byKey(const ValueKey<String>('dsProductListGridItem_0')));
      await tester.pumpAndSettle();
      expect(cardTocada, isTrue);
    });

    testWidgets('debería mostrar rating y badge en modo grid sin botón de agregar', (
      WidgetTester tester,
    ) async {
      // Arrange
      final List<ProductItem> items = <ProductItem>[
        const ProductItem(
          id: 3,
          imageUrl: 'https://example.com/grid.png',
          title: 'Grid item',
          price: '\$35',
          rating: 3.5,
          badgeText: 'Nuevo',
        ),
      ];
      final Widget widget = DSProductList(
        products: items,
        isGrid: true,
        showAddButton: false,
        showMenuChange: false,
        showImageTopSpacing: true,
        isMedal: true,
      );

      // Act
      await runWithNetworkImageMocks(() async {
        await tester.pumpWidget(wrapWithFakeAssetBundle(widget));
        await tester.pumpAndSettle();
      });

      // Assert
      expect(find.byKey(const ValueKey<String>('dsProductCardBadge')), findsOneWidget);
    });
  });

  group('ProductItem', () {
    test('debería soportar copyWith y comparaciones', () {
      const ProductItem original = ProductItem(
        id: 1,
        imageUrl: 'img',
        title: 'Titulo',
        price: '10',
        rating: 2,
      );

      final ProductItem copia = original.copyWith(title: 'Nuevo', price: '20');

      expect(copia.title, 'Nuevo');
      expect(copia.price, '20');
      expect(original == copia, isTrue); // igualdad basada en id
    });

    test('ProductItemMapper debería transformar mapas en objetos', () {
      final List<Map<String, dynamic>> data = <Map<String, dynamic>>[
        {
          'id': 5,
          'imageUrl': 'url',
          'title': 'Item',
          'price': '99',
        },
      ];

      final List<ProductItem> items = ProductItemMapper().fromMap(data);
      expect(items, hasLength(1));
      expect(items.first.id, 5);
      expect(items.first.title, 'Item');
    });
  });
}
