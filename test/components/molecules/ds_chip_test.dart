import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/src/components/molecules/ds_chip.dart';

/// Agrupa las pruebas de la molécula `DSChip`.
void main() {
  group('DSChip', () {
    testWidgets('should display icon and label when provided', (
      WidgetTester tester,
    ) async {
      // Arrange
      const Widget widget = DSChip(label: 'Flutter', icon: Icons.flutter_dash);

      // Act
      await tester.pumpWidget(_buildTestable(widget));

      // Assert
      expect(find.byKey(const ValueKey<String>('dsChipIcon')), findsOneWidget);
      expect(find.byKey(const ValueKey<String>('dsChipLabel')), findsOneWidget);
      expect(find.text('Flutter'), findsOneWidget);
    });

    testWidgets('should trigger onTap only when the chip is enabled', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool enabledTriggered = false;
      bool disabledTriggered = false;

      final Widget widget = Column(
        children: <Widget>[
          DSChip(label: 'Enabled', onTap: () => enabledTriggered = true),
          DSChip(
            label: 'Disabled',
            enabled: false,
            onTap: () => disabledTriggered = true,
          ),
        ],
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));
      final Finder gestures = find.byKey(
        const ValueKey<String>('dsChipGestureDetector'),
      );
      await tester.tap(gestures.at(0));
      await tester.tap(gestures.at(1));
      await tester.pumpAndSettle();

      // Assert
      expect(enabledTriggered, isTrue);
      expect(disabledTriggered, isFalse);
    });
  });
}

/// Crea la envoltura necesaria para renderizar la molécula.
Widget _buildTestable(Widget child) {
  return MaterialApp(
    home: Scaffold(body: Center(child: child)),
  );
}
