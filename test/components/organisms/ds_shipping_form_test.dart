import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/src/components/organisms/ds_shipping_form.dart';

/// Casos de prueba para el organismo `DSShippingForm`.
void main() {
  group('DSShippingForm', () {
    testWidgets('debería validar los campos y retornar el método seleccionado', (
      WidgetTester tester,
    ) async {
      // Arrange
      Map<String, String>? data;
      final Map<String, dynamic> config = {
        'title': 'Dirección',
        'fields': {
          'name': {'label': 'Nombre', 'hint': 'Nombre', 'required': true},
          'city': {'label': 'Ciudad', 'hint': 'Ciudad'},
          'zip': {'label': 'CP', 'hint': '05001'},
        },
        'shippingMethods': [
          {'label': 'Estándar', 'subtitle': '3-5 días'},
          {'label': 'Exprés', 'subtitle': '1-2 días'},
        ],
      };
      final Widget widget = DSShippingForm(
        config: config,
        onSubmit: (Map<String, String> value) => data = value,
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));
      await tester.enterText(find.byType(TextFormField).at(0), 'Carlos');
      await tester.enterText(find.byType(TextFormField).at(1), 'Medellín');
      await tester.enterText(find.byType(TextFormField).at(2), '05001');
      await tester.tap(
        find.byKey(const ValueKey<String>('dsShippingOptionGesture_Exprés')),
      );
      await tester.pumpAndSettle();
      await tester.tap(
        find.byKey(const ValueKey<String>('dsShippingFormSubmitButton')),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(data?['name'], 'Carlos');
      expect(data?['shippingMethod'], 'Exprés');
    });
  });
}

/// Construye el árbol básico para el formulario de envío.
Widget _buildTestable(Widget child) {
  return MaterialApp(
    home: Scaffold(body: SingleChildScrollView(child: child)),
  );
}
