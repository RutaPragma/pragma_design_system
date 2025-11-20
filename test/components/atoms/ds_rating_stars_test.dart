import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/src/components/atoms/ds_rating_stars.dart';

/// Verificaciones del átomo `DSRatingStars`.
void main() {
  group('DSRatingStars', () {
    testWidgets('debería pintar estrellas de acuerdo con la calificación', (
      WidgetTester tester,
    ) async {
      // Arrange
      const Widget widget = DSRatingStars(rating: 3.5);

      // Act
      await tester.pumpWidget(_buildTestable(widget));

      // Assert
      expect(find.byIcon(Icons.star_rounded), findsNWidgets(3));
      expect(find.byIcon(Icons.star_half_rounded), findsOneWidget);
      expect(find.byIcon(Icons.star_border_rounded), findsOneWidget);
    });

    testWidgets('debería notificar el nuevo valor cuando es interactivo', (
      WidgetTester tester,
    ) async {
      // Arrange
      double? ultimoValor;
      final Widget widget = DSRatingStars(
        rating: 2,
        isInteractive: true,
        onChanged: (double valor) => ultimoValor = valor,
      );

      // Act
      await tester.pumpWidget(_buildTestable(widget));
      await tester.tap(find.byKey(const ValueKey<String>('dsRatingStarGesture_4')));
      await tester.pumpAndSettle();

      // Assert
      expect(ultimoValor, 4);
    });
  });
}

/// Construye la envoltura mínima para renderizar el widget.
Widget _buildTestable(Widget child) {
  return MaterialApp(
    home: Scaffold(body: Center(child: child)),
  );
}
