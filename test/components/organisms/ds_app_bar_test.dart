import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/src/components/organisms/ds_app_bar.dart';

/// Casos de prueba del organismo `DSAppBar`.
void main() {
  group('DSAppBar', () {
    testWidgets('debería mostrar título, subtítulo y botón de regreso', (
      WidgetTester tester,
    ) async {
      // Arrange
      const DSAppBar widget = DSAppBar(
        title: 'Productos',
        subtitle: 'Destacados',
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));

      // Assert
      expect(find.byKey(const ValueKey<String>('dsAppBarBackButton')), findsOneWidget);
      expect(find.text('Productos'), findsOneWidget);
      expect(find.text('Destacados'), findsOneWidget);
    });

    testWidgets('debería invocar la acción predeterminada cuando se presiona el ícono', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool accionInvocada = false;
      final DSAppBar widget = DSAppBar(
        title: 'Inicio',
        showBackButton: false,
        onActionIconPress: () => accionInvocada = true,
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));
      await tester.tap(find.byKey(const ValueKey<String>('dsAppBarDefaultActionIcon')));
      await tester.pumpAndSettle();

      // Assert
      expect(accionInvocada, isTrue);
    });
  });
}

/// Genera un árbol mínimo de Material para el AppBar.
Widget _buildTestable(PreferredSizeWidget appBar) {
  return MaterialApp(
    home: Scaffold(appBar: appBar),
  );
}
