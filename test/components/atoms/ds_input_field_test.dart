import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/src/components/atoms/ds_input_field.dart';

/// Escenarios de prueba del átomo `DSInputField`.
void main() {
  group('DSInputField', () {
    testWidgets('debería mostrar la etiqueta y el hint configurados', (
      WidgetTester tester,
    ) async {
      // Arrange
      const Widget widget = DSInputField(
        label: 'Correo',
        hintText: 'correo@dominio.com',
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));

      // Assert
      expect(find.text('Correo'), findsOneWidget);
      expect(find.text('correo@dominio.com'), findsOneWidget);
    });

    testWidgets('debería propagar el callback onChanged cuando cambia el texto', (
      WidgetTester tester,
    ) async {
      // Arrange
      String ultimoValor = '';
      final Widget widget = DSInputField(
        label: 'Usuario',
        onChanged: (String valor) => ultimoValor = valor,
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));
      await tester.enterText(
        find.byType(TextFormField),
        'john@pragma.dev',
      );

      // Assert
      expect(ultimoValor, 'john@pragma.dev');
    });
  });
}

/// Retorna un `MaterialApp` básico para renderizar el campo.
Widget _buildTestable(Widget child) {
  return MaterialApp(
    home: Scaffold(body: Center(child: child)),
  );
}
