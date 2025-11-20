import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/src/components/pages/home_page.dart';

import '../../helpers/widget_test_utils.dart';

/// Verificaciones de la página principal.
void main() {
  group('HomePage', () {
    testWidgets('debería mostrar el loader mientras carga', (
      WidgetTester tester,
    ) async {
      // Arrange & Act
      await runWithNetworkImageMocks(() async {
        await tester.pumpWidget(_buildTestable());
        await tester.pump(const Duration(milliseconds: 100));
        expect(find.byKey(const ValueKey<String>('homePageLoader')), findsOneWidget);

        // Limpia temporizadores pendientes dentro del mismo contexto.
        await tester.pump(const Duration(seconds: 1));
      });
    });

    testWidgets('debería renderizar el template después de cargar', (
      WidgetTester tester,
    ) async {
      // Arrange & Act
      await runWithNetworkImageMocks(() async {
        await tester.pumpWidget(_buildTestable());
        await tester.pump(const Duration(seconds: 1));
        await tester.pump();
      });

      // Assert
      expect(find.byKey(const ValueKey<String>('homePageTemplate')), findsOneWidget);
    });
  });
}

/// Construye el árbol base incluyendo el mock de assets.
Widget _buildTestable() {
  registerMockAssets();
  return const MaterialApp(home: HomePage());
}
