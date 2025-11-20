import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/src/components/templates/ds_home_template.dart';

import '../../helpers/widget_test_utils.dart';

/// Casos de prueba para `DSHomeTemplate`.
void main() {
  group('DSHomeTemplate', () {
    testWidgets('debería ejecutar las acciones de búsqueda y agregar producto', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.binding.setSurfaceSize(const Size(1200, 1600));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      String? ultimoTermino;
      bool agrego = false;
      final Widget widget = DSHomeTemplate(
        config: {
          'banner': {
            'title': 'Promo',
            'subtitle': 'Solo hoy',
            'imageUrl': 'https://example.com/banner.png',
          },
          'sections': [
            {
              'title': 'Destacados',
              'products': [
                {
                  'id': 1,
                  'imageUrl': 'https://example.com/product.png',
                  'title': 'Producto',
                  'price': '\$10',
                },
              ],
            },
          ],
          'emptyImagePath': 'empty.png',
        },
        selectIndex: 0,
        onNavItemSelect: (_) {},
        onSearch: (value) => ultimoTermino = value,
        onAddPressed: (_) => agrego = true,
        onTapPressed: (_) {},
      );

      // Act
      await runWithNetworkImageMocks(() async {
        await tester.pumpWidget(
          wrapWithFakeAssetBundle(
            Center(child: SizedBox(width: 500, child: widget)),
          ),
        );
        await tester.pump();
      });

      await tester.enterText(
        find.byKey(const ValueKey<String>('dsSearchBarTextField')),
        'Zapatos',
      );
      await tester.pump(const Duration(milliseconds: 600));

      final Finder addButton = find.byKey(
        const ValueKey<String>('dsProductCardButton'),
      );
      await tester.ensureVisible(addButton);
      await tester.tap(addButton, warnIfMissed: false);
      await tester.pumpAndSettle();

      // Assert
      expect(ultimoTermino, 'Zapatos');
      expect(agrego, isTrue);
      expect(find.byKey(const ValueKey<String>('dsHomeTemplateSectionList_0')), findsOneWidget);
    });
  });
}
