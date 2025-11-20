import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/src/components/atoms/ds_separeted.dart';
import 'package:pragma_design_system/src/foundations/ds_sizes_foundations.dart';

/// Punto de entrada de los tests del átomo `DSSepareted`.
void main() {
  group('DSSepareted', () {
    testWidgets('should expose a SizedBox with the expected height', (
      WidgetTester tester,
    ) async {
      // Arrange
      const double separated = 2;
      const DSSepareted widget = DSSepareted(separated);

      // Act
      await tester.pumpWidget(_buildTestable(widget));

      // Assert
      final SizedBox box = tester.widget(
        find.byKey(const ValueKey<String>('dsSeparatedSizedBox')),
      );
      expect(box.height, separated * DSSizesFoundations.separatorSmall);
    });

    testWidgets('should allow composing layouts inside Flex widgets', (
      WidgetTester tester,
    ) async {
      // Arrange
      const Widget widget = Column(
        children: <Widget>[Text('first'), DSSepareted(1), Text('second')],
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));

      // Assert
      expect(find.text('first'), findsOneWidget);
      expect(find.text('second'), findsOneWidget);
      expect(
        find.byKey(const ValueKey<String>('dsSeparatedSizedBox')),
        findsOneWidget,
      );
    });
  });
}

/// Construye un arbol mínimo para renderizar el widget bajo prueba.
Widget _buildTestable(Widget child) {
  return MaterialApp(
    home: Scaffold(body: Center(child: child)),
  );
}
