import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/src/components/organisms/ds_payment_methods.dart';

import '../../helpers/widget_test_utils.dart';

/// Suite de pruebas para `DSPaymentMethods`.
void main() {
  group('DSPaymentMethods', () {
    testWidgets('debería renderizar todos los métodos y sus badges', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.binding.setSurfaceSize(const Size(1200, 900));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final List<PaymentMethodModel> methods = <PaymentMethodModel>[
        PaymentMethodModel(label: 'T', iconPath: 'visa.png'),
        PaymentMethodModel(label: 'P', iconPath: 'paypal.png', badge: 'Top'),
      ];
      final Widget widget = DSPaymentMethods(
        title: 'Pagos',
        methods: methods,
        selectedIndex: 1,
      );

      // Act
      await tester.pumpWidget(
        wrapWithFakeAssetBundle(
          Center(
            child: FittedBox(
              alignment: Alignment.topCenter,
              child: SizedBox(width: 1200, child: widget),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Pagos'), findsOneWidget);
      expect(find.byKey(const ValueKey<String>('dsPaymentMethodButton_0')), findsOneWidget);
      expect(find.byKey(const ValueKey<String>('dsPaymentMethodBadge_1')), findsOneWidget);
    });

    testWidgets('debería notificar el índice seleccionado al tocar un método', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.binding.setSurfaceSize(const Size(1200, 900));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      int? seleccionado;
      final Widget widget = DSPaymentMethods(
        title: 'Pagos',
        methods: <PaymentMethodModel>[
          PaymentMethodModel(label: 'T', iconPath: 'visa.png'),
          PaymentMethodModel(label: 'E', iconPath: 'cash.png'),
        ],
        onSelected: (int index) => seleccionado = index,
      );

      // Act
      await tester.pumpWidget(
        wrapWithFakeAssetBundle(
          Center(
            child: FittedBox(
              alignment: Alignment.topCenter,
              child: SizedBox(width: 1200, child: widget),
            ),
          ),
        ),
      );
      await tester.tap(
        find.byKey(const ValueKey<String>('dsPaymentMethodButton_1')),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(seleccionado, 1);
    });
  });
}
