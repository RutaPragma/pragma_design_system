import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/src/components/organisms/ds_auth_form.dart';

/// Casos de prueba del organismo `DSAuthForm`.
void main() {
  group('DSAuthForm', () {
    testWidgets('debería validar los campos y propagar el submit', (
      WidgetTester tester,
    ) async {
      // Arrange
      String? email;
      String? password;
      final Map<String, dynamic> config = {
        'title': 'Login',
        'emailLabel': 'Correo',
        'passwordLabel': 'Clave',
      };
      final Widget widget = DSAuthForm(
        config: config,
        onSubmit: (String e, String p) {
          email = e;
          password = p;
        },
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));
      await tester.enterText(find.byType(TextFormField).at(0), 'user@pragma.dev');
      await tester.enterText(find.byType(TextFormField).at(1), '123456');
      await tester.tap(find.byKey(const ValueKey<String>('dsAuthFormSubmitButton')));
      await tester.pumpAndSettle();

      // Assert
      expect(email, 'user@pragma.dev');
      expect(password, '123456');
    });

    testWidgets('debería mostrar el botón de olvidar contraseña y ejecutarlo', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool callbackInvocado = false;
      final Widget widget = DSAuthForm(
        config: const {'title': 'Login'},
        onForgotPassword: () => callbackInvocado = true,
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));
      await tester.tap(
        find.byKey(const ValueKey<String>('dsAuthFormForgotPasswordButton')),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(callbackInvocado, isTrue);
    });

    testWidgets('debería mostrar mensajes de error cuando los campos son inválidos', (
      WidgetTester tester,
    ) async {
      // Arrange
      final Widget widget = DSAuthForm(
        config: const {
          'title': 'Login',
          'emailRequired': 'Correo obligatorio',
          'passwordRequired': 'Clave obligatoria',
        },
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));
      await tester.tap(find.byKey(const ValueKey<String>('dsAuthFormSubmitButton')));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Correo obligatorio'), findsOneWidget);
      expect(find.text('Clave obligatoria'), findsOneWidget);
    });

    testWidgets('debería mostrar loader cuando se encuentra cargando', (
      WidgetTester tester,
    ) async {
      // Arrange
      const Widget widget = DSAuthForm(
        config: {'title': 'Login'},
        isLoading: true,
        showForgotPassword: false,
        showPasswordToggle: false,
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));

      // Assert
      expect(find.byKey(const ValueKey<String>('dsAuthFormLoader')), findsOneWidget);
      expect(find.byKey(const ValueKey<String>('dsAuthFormForgotPasswordButton')), findsNothing);
    });
  });
}

/// Construye un árbol de Material para el formulario de autenticación.
Widget _buildTestable(Widget child) {
  return MaterialApp(
    home: Scaffold(body: SingleChildScrollView(child: child)),
  );
}
