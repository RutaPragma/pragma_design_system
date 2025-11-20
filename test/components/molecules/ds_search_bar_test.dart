import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/src/components/molecules/ds_search_bar.dart';

/// Suite de pruebas para `DSSearchBar`.
void main() {
  group('DSSearchBar', () {
    testWidgets('debería emitir onChanged luego del tiempo de debounce', (
      WidgetTester tester,
    ) async {
      // Arrange
      String ultimoValor = '';
      final Widget widget = DSSearchBar(
        hintText: 'Buscar productos',
        debounceDuration: const Duration(milliseconds: 30),
        onChanged: (String valor) => ultimoValor = valor,
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));
      await tester.enterText(
        find.byKey(const ValueKey<String>('dsSearchBarTextField')),
        'Zapatos',
      );
      await tester.pump(const Duration(milliseconds: 40));

      // Assert
      expect(ultimoValor, 'Zapatos');
    });

    testWidgets('debería mostrar el botón de limpiar y ejecutar onClear', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool seLimpio = false;
      final TextEditingController controller = TextEditingController(text: 'Init');
      final Widget widget = DSSearchBar(
        controller: controller,
        onClear: () => seLimpio = true,
        onChanged: (_) {},
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));
      expect(find.byKey(const ValueKey<String>('dsSearchBarClearGesture')), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey<String>('dsSearchBarClearGesture')));
      await tester.pumpAndSettle();

      // Assert
      expect(controller.text, isEmpty);
      expect(seLimpio, isTrue);
    });

    testWidgets('no debería mostrar el botón de limpiar cuando no hay texto', (
      WidgetTester tester,
    ) async {
      // Arrange
      const Widget widget = DSSearchBar(
        hintText: 'Buscar...',
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));

      // Assert
      expect(find.byKey(const ValueKey<String>('dsSearchBarClearGesture')), findsNothing);
    });
  });
}

/// Devuelve un entorno Material básico para el widget.
Widget _buildTestable(Widget child) {
  return MaterialApp(
    home: Scaffold(body: Center(child: child)),
  );
}
