import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/components/atoms/atoms.dart';
import 'package:pragma_design_system/src/components/molecules/molecules.dart';
import 'package:pragma_design_system/src/foundations/foundations.dart';

/// Organismo que agrupa y muestra los métodos de pago disponibles.
///
/// Cada método utiliza internamente un [DSPaymentButton], lo que garantiza
/// consistencia visual con el resto del sistema.
///
/// Ejemplo de uso:
/// ```dart
/// DSPaymentMethods(
///   title: "Métodos de pago",
///   methods: [
///     PaymentMethodModel(
///       label: "Tarjeta de crédito",
///       iconPath: "assets/icons/svg/fi-cc-visa.svg",
///       description: "Visa, MasterCard, Amex",
///     ),
///     PaymentMethodModel(
///       label: "PayPal",
///       iconPath: "assets/icons/svg/fi-brands-paypal.svg",
///     ),
///     PaymentMethodModel(
///       label: "Pago contra entrega",
///       iconPath: "assets/icons/svg/fi-rr-wallet.svg",
///       description: "Efectivo o datafono",
///       badge: "Recomendado",
///     ),
///   ],
///   selectedIndex: 0,
///   onSelected: (index) => print("Seleccionado: $index"),
/// )
/// ```
class DSPaymentMethods extends StatelessWidget {
  final String title;
  final List<PaymentMethodModel> methods;
  final int selectedIndex;
  final ValueChanged<int>? onSelected;
  final Color? backgroundColor;
  final Color? textColor;

  const DSPaymentMethods({
    super.key,
    required this.title,
    required this.methods,
    this.selectedIndex = -1,
    this.onSelected,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bgColor =
        backgroundColor ??
        (isDark
            ? DSColorsFoundations.surfaceDark
            : DSColorsFoundations.surfaceLight);

    final txtColor =
        textColor ??
        (isDark
            ? DSColorsFoundations.textPrimaryDark
            : DSColorsFoundations.textPrimary);

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(DSRadiusFoundations.radiusMD),
        boxShadow: DSShadowsFoundations.shadowSmall,
      ),
      padding: EdgeInsets.all(DSSizesFoundations.separatorLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: DSTypographyFoundations.displayMedium.copyWith(
              color: txtColor,
            ),
          ),
          SizedBox(height: DSSizesFoundations.separatorMedium),
          ...List.generate(methods.length, (index) {
            final method = methods[index];
            var isSelected = index == selectedIndex;
            return Padding(
              padding: EdgeInsets.only(
                bottom: DSSizesFoundations.separatorMedium,
              ),
              child: Stack(
                children: [
                  DSPaymentButton(
                    logo: Image.asset(
                      method.iconPath,
                      height: 24,
                      color: isDark
                          ? DSColorsFoundations.textOnPrimary
                          : DSColorsFoundations.textOnPrimaryDark,
                    ),
                    label: method.label,
                    // description: method.description,
                    isSelected: isSelected,
                    onPressed: () => onSelected?.call(index),
                  ),
                  if (method.badge != null)
                    Positioned(
                      right: DSSizesFoundations.separatorSmall,
                      top: DSSizesFoundations.separatorSmall,
                      child: DSBadge(
                        label: method.badge!,
                        backgroundColor: DSColorsFoundations.brandSecondary,
                        textColor: DSColorsFoundations.textOnPrimaryDark,
                        isMedal: false,
                      ),
                    ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

/// Modelo para representar un método de pago dentro del organismo.
class PaymentMethodModel {
  final String label;
  final String iconPath;
  final String? description;
  final String? badge;
  final ValueChanged<int>? onSelected;

  PaymentMethodModel({
    required this.label,
    required this.iconPath,
    this.description,
    this.badge,
    this.onSelected,
  });
}

class PaymentMethodMapper {
  static List<PaymentMethodModel> fromMapList(List<dynamic> data) {
    return data.map((map) {
      return PaymentMethodModel(
        label: map['label'] ?? '',
        iconPath: map['iconPath'] ?? '',
        description: map['description'],
        badge: map['badge'],
        onSelected: null,
      );
    }).toList();
  }
}
