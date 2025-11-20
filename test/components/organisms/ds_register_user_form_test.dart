import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/src/components/organisms/ds_register_user_form.dart';

/// Suite de pruebas para `DSRegisterUserForm`.
void main() {
  group('DSRegisterUserForm', () {
    testWidgets('debería validar los campos y enviar la información', (
      WidgetTester tester,
    ) async {
      // Arrange
      Map<String, String>? payload;
      final Widget widget = DSRegisterUserForm(
        config: const {'title': 'Registro'},
        onSubmit: (Map<String, String> data) => payload = data,
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));
      await tester.enterText(find.byType(TextFormField).at(0), 'Juan Perez');
      await tester.enterText(find.byType(TextFormField).at(1), 'juan@pragma.dev');
      await tester.enterText(find.byType(TextFormField).at(2), '123456');
      await tester.enterText(find.byType(TextFormField).at(3), '123456');
      await tester.tap(
        find.byKey(const ValueKey<String>('dsRegisterFormSubmitButton')),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(payload?['name'], 'Juan Perez');
      expect(payload?['email'], 'juan@pragma.dev');
      expect(payload?['password'], '123456');
    });

    testWidgets('debería permitir mostrar u ocultar ambas contraseñas', (
      WidgetTester tester,
    ) async {
      // Arrange
      final Widget widget = DSRegisterUserForm(
        config: const {'title': 'Registro'},
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));
      await tester.tap(
        find.byKey(const ValueKey<String>('dsRegisterFormPasswordToggle')),
      );
      await tester.pump();
      await tester.tap(
        find.byKey(const ValueKey<String>('dsRegisterFormConfirmPasswordToggle')),
      );
      await tester.pump();

      // Assert
      expect(find.byIcon(Icons.visibility).evaluate().length, greaterThanOrEqualTo(2));
    });

    testWidgets('debería mostrar error cuando las contraseñas no coinciden', (
      WidgetTester tester,
    ) async {
      // Arrange
      final Widget widget = DSRegisterUserForm(
        config: const {'title': 'Registro'},
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));
      await tester.enterText(find.byType(TextFormField).at(0), 'Juan');
      await tester.enterText(find.byType(TextFormField).at(1), 'juan@pragma.dev');
      await tester.enterText(find.byType(TextFormField).at(2), '123456');
      await tester.enterText(find.byType(TextFormField).at(3), '654321');
      await tester.tap(
        find.byKey(const ValueKey<String>('dsRegisterFormSubmitButton')),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Las contraseñas no coinciden'), findsOneWidget);
    });

    testWidgets('debería mostrar loader cuando isLoading es true', (
      WidgetTester tester,
    ) async {
      // Arrange
      const Widget widget = DSRegisterUserForm(
        config: {'title': 'Registro'},
        isLoading: true,
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));

      // Assert
      expect(find.byKey(const ValueKey<String>('dsRegisterFormLoader')), findsOneWidget);
      expect(find.byKey(const ValueKey<String>('dsRegisterFormSubmitButton')), findsNothing);
    });
  });
}

/// Construye el árbol base de Material para el formulario de registro.
Widget _buildTestable(Widget child) {
  return MaterialApp(
    home: Scaffold(body: SingleChildScrollView(child: child)),
  );
}
