import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/src/components/atoms/icons/ds_icon.dart';
import 'package:pragma_design_system/src/foundations/ds_colors_foundation.dart';
import 'package:pragma_design_system/src/utils/enums.dart';

/// Escenarios de verificación para el átomo `DSIcon`.
void main() {
  group('DSIcon', () {
    testWidgets('debería respetar el tamaño personalizado definido', (
      WidgetTester tester,
    ) async {
      // Arrange
      const Widget widget = DSIcon(
        icon: Icons.alarm,
        customSize: 42,
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));
      final Icon icon = tester.widget(find.byKey(const ValueKey<String>('dsIcon')));

      // Assert
      expect(icon.size, 42);
    });

    testWidgets('debería ejecutar el callback al tocar el ícono', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool fueInvocado = false;
      final Widget widget = DSIcon(
        icon: Icons.favorite,
        onPressed: () => fueInvocado = true,
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));
      await tester.tap(find.byKey(const ValueKey<String>('dsIconGesture')));
      await tester.pumpAndSettle();

      // Assert
      expect(fueInvocado, isTrue);
    });

    testWidgets('debería respetar el color personalizado cuando se provee', (
      WidgetTester tester,
    ) async {
      // Arrange
      const Widget widget = DSIcon(
        icon: Icons.home,
        customColor: Colors.green,
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));
      final Icon icon = tester.widget(find.byKey(const ValueKey<String>('dsIcon')));

      // Assert
      expect(icon.color, Colors.green);
    });

    testWidgets('debería usar el color semántico para estado disabled', (
      WidgetTester tester,
    ) async {
      // Arrange
      const Widget widget = DSIcon(
        icon: Icons.person,
        color: DSIconColor.disabled,
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(brightness: Brightness.light),
          home: const Scaffold(body: Center(child: widget)),
        ),
      );
      final Icon icon = tester.widget(find.byKey(const ValueKey<String>('dsIcon')));

      // Assert
      expect(icon.color, DSColorsFoundations.textHint);
    });
  });
}

/// Retorna un MaterialApp mínimo para renderizar el ícono.
Widget _buildTestable(Widget child) {
  return MaterialApp(
    home: Scaffold(body: Center(child: child)),
  );
}
