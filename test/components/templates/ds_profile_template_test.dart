import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/src/components/templates/ds_profile_template.dart';

import '../../helpers/widget_test_utils.dart';

/// Verificaciones del template `DSProfileTemplate`.
void main() {
  group('DSProfileTemplate', () {
    testWidgets('debería renderizar la información del usuario y ejecutar acciones', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool logout = false;
      bool edit = false;
      bool viewOrder = false;
      bool settingTap = false;

      final Widget widget = DSProfileTemplate(
        config: {
          'user': {
            'name': 'Usuario',
            'email': 'correo@demo.com',
            'onEdit': () => edit = true,
          },
          'orders': [
            {
              'id': 'A1',
              'date': 'Hoy',
              'status': 'Nuevo',
              'onView': () => viewOrder = true,
            },
          ],
          'settings': [
            {
              'icon': Icons.settings,
              'title': 'Preferencias',
              'onTap': () => settingTap = true,
            },
          ],
          'onLogout': () => logout = true,
        },
      );

      // Act
      await tester.pumpWidget(wrapWithFakeAssetBundle(widget));
      await tester.tap(find.byKey(const ValueKey<String>('dsProfileTemplateLogoutButton')));
      await tester.tap(find.byKey(const ValueKey<String>('dsProfileTemplateEditButton')));
      await tester.tap(find.byKey(const ValueKey<String>('dsProfileTemplateOrderButton_0')));
      await tester.tap(find.text('Preferencias'));
      await tester.pumpAndSettle();

      // Assert
      expect(logout, isTrue);
      expect(edit, isTrue);
      expect(viewOrder, isTrue);
      expect(settingTap, isTrue);
      expect(find.text('Usuario'), findsOneWidget);
    });
  });
}
