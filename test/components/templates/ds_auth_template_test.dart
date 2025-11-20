import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/src/components/atoms/buttons/ds_button.dart';
import 'package:pragma_design_system/src/components/templates/ds_auth_template.dart';

/// Suite de validación para `DSAuthTemplate`.
void main() {
  group('DSAuthTemplate', () {
    testWidgets('debería alternar entre login y registro', (
      WidgetTester tester,
    ) async {
      // Arrange
      const Widget widget = DSAuthTemplate(
        config: <String, dynamic>{
          'loginConfig': <String, dynamic>{'title': 'Inicia sesión'},
          'registerConfig': <String, dynamic>{'title': 'Crea tu cuenta'},
        },
        onLogin: _noopLogin,
        onRegister: _noopRegister,
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));

      // Assert login visible
      expect(find.text('Inicia sesión'), findsOneWidget);

      // Act toggle
      await tester.tap(find.byKey(const ValueKey<String>('dsAuthTemplateToggleAction')));
      await tester.pumpAndSettle();

      // Assert register visible
      expect(find.text('Crea tu cuenta'), findsOneWidget);
    });

    testWidgets('debería mostrar botones sociales personalizados', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool socialTriggered = false;
      final Widget widget = DSAuthTemplate(
        config: const <String, dynamic>{
          'loginConfig': <String, dynamic>{},
        },
        onLogin: _noopLogin,
        onRegister: _noopRegister,
        socialButtons: <DSButton>[
          DSButton(
            key: const ValueKey<String>('socialButton'),
            label: 'Google',
            onPressed: () => socialTriggered = true,
          ),
        ],
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));
      await tester.tap(find.byKey(const ValueKey<String>('socialButton')));
      await tester.pumpAndSettle();

      // Assert
      expect(socialTriggered, isTrue);
    });
  });
}

/// Genera el contenedor de pruebas.
Widget _buildTestable(Widget child) {
  return MaterialApp(home: Scaffold(body: child));
}

void _noopLogin(String _, String __) {}

void _noopRegister(Map<String, dynamic> _) {}
