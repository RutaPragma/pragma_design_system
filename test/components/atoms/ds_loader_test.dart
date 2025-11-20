import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/src/components/atoms/ds_loader.dart';

/// Validaciones para el átomo `DSLoader`.
void main() {
  group('DSLoader', () {
    testWidgets('debería mostrar el texto configurado en pantalla', (
      WidgetTester tester,
    ) async {
      // Arrange
      const Widget widget = DSLoader(label: 'Preparando');

      // Act
      await tester.pumpWidget(_buildTestable(widget));

      // Assert
      expect(find.textContaining('Preparando'), findsOneWidget);
    });

    testWidgets('debería respetar el tamaño solicitado', (
      WidgetTester tester,
    ) async {
      // Arrange
      const Widget widget = DSLoader(size: 80);

      // Act
      await tester.pumpWidget(_buildTestable(widget));

      // Assert
      final Iterable<SizedBox> cajas = tester
          .widgetList(find.byType(SizedBox))
          .whereType<SizedBox>()
          .where((SizedBox box) => box.width == 80 && box.height == 80);
      expect(cajas.isNotEmpty, isTrue);
    });
  });
}

/// Genera la envoltura de Material para visualizar el loader.
Widget _buildTestable(Widget child) {
  return MaterialApp(
    home: Scaffold(body: Center(child: child)),
  );
}
