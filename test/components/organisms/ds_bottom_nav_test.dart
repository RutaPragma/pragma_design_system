import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/src/components/organisms/ds_bottom_nav.dart';

/// Validaciones para el organismo `DSBottomNav`.
void main() {
  group('DSBottomNav', () {
    testWidgets('debería notificar el índice seleccionado al tocar un ítem', (
      WidgetTester tester,
    ) async {
      // Arrange
      int? seleccionado;
      final Widget widget = DSBottomNav(
        items: const [
          DSBottomNavItem(icon: Icons.home, label: 'Inicio'),
          DSBottomNavItem(icon: Icons.person, label: 'Perfil'),
        ],
        currentIndex: 0,
        onItemSelected: (int value) => seleccionado = value,
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));
      await tester.tap(find.byKey(const ValueKey<String>('dsBottomNavInkWell_1')));
      await tester.pumpAndSettle();

      // Assert
      expect(seleccionado, 1);
    });

    testWidgets('debería mostrar badge recortado cuando el valor es superior a 9', (
      WidgetTester tester,
    ) async {
      // Arrange
      final Widget widget = DSBottomNav(
        items: const [
          DSBottomNavItem(icon: Icons.home, label: 'Inicio', badgeCount: 12),
          DSBottomNavItem(icon: Icons.person, label: 'Perfil'),
        ],
        currentIndex: 0,
        onItemSelected: (_) {},
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));

      // Assert
      expect(find.text('9+'), findsOneWidget);
    });
  });
}

/// Construye un árbol Material para la barra inferior.
Widget _buildTestable(Widget child) {
  return MaterialApp(
    home: Scaffold(bottomNavigationBar: child),
  );
}
