import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/src/components/molecules/ds_promo_banner.dart';

import '../../helpers/widget_test_utils.dart';

/// Pruebas para la molécula `DSPromoBanner`.
void main() {
  group('DSPromoBanner', () {
    testWidgets('debería mostrar badge, título y botón configurados', (
      WidgetTester tester,
    ) async {
      // Arrange
      final Widget widget = DSPromoBanner(
        title: 'Ofertas Flash',
        subtitle: 'Solo hoy',
        badgeText: 'Nuevo',
        buttonLabel: 'Ver más',
        onPressed: () {},
        imageUrl: 'https://example.com/banner.png',
        size: 220,
      );

      // Act
      await runWithNetworkImageMocks(() async {
        await tester.pumpWidget(_buildTestable(widget));
        await tester.pump();
      });

      // Assert
      expect(find.text('Ofertas Flash'), findsOneWidget);
      expect(find.text('Solo hoy'), findsOneWidget);
      expect(find.text('NUEVO'), findsOneWidget);
      expect(find.text('Ver más'), findsOneWidget);
    });

    testWidgets('debería ajustar el layout cuando se invierte el banner', (
      WidgetTester tester,
    ) async {
      // Arrange
      const Widget widget = DSPromoBanner(
        title: 'Promo',
        isReversed: true,
        imageUrl: 'https://example.com/banner.png',
        size: 220,
      );

      // Act
      await runWithNetworkImageMocks(() async {
        await tester.pumpWidget(_buildTestable(widget));
        await tester.pump();
      });

      // Assert
      final Row row = tester.widget(find.byKey(const ValueKey<String>('dsPromoBannerRow')));
      // Cuando está invertido, el contenido debe ser el segundo hijo.
      expect(row.children.first.key, const ValueKey<String>('dsPromoBannerImageExpanded'));
      expect(row.children.last.key, const ValueKey<String>('dsPromoBannerContent'));
    });
  });
}

/// Genera un entorno Material básico para la molécula.
Widget _buildTestable(Widget child) {
  return MaterialApp(
    home: Scaffold(body: Center(child: child)),
  );
}
