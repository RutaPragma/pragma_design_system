import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/foundations/foundations.dart';

/// Molécula: DSPaymentButton
///
/// Representa una opción de pago (Visa, MasterCard, PayPal, etc.)
/// Altamente parametrizable y adaptado a temas claro/oscuro.
///
/// Ejemplo:
/// ```dart
/// DSPaymentButton(
///   label: "Pagar con PayPal",
///   logo: Image.asset("assets/paypal_logo.png", height: 24),
///   onPressed: () {},
/// )
/// ```
class DSPaymentButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  /// Widget del logo del método de pago (asset o icono)
  final Widget? logo;

  /// Colores personalizables
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;

  /// Tamaño, borde, y sombra
  final double? borderRadius;
  final bool showShadow;

  /// Estado de selección (opcional)
  final bool isSelected;

  /// Deshabilitado
  final bool enabled;

  /// Ícono opcional a la derecha (por ejemplo, una flecha)
  final IconData? trailingIcon;

  const DSPaymentButton({
    super.key,
    required this.label,
    this.onPressed,
    this.logo,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderRadius,
    this.showShadow = true,
    this.isSelected = false,
    this.enabled = true,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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

    final brdColor =
        borderColor ??
        (isSelected
            ? (isDark
                  ? DSColorsFoundations.brandPrimaryDark
                  : DSColorsFoundations.brandPrimary)
            : (isDark
                  ? DSColorsFoundations.inputBorderDark
                  : DSColorsFoundations.inputBorder));

    final shadow = showShadow
        ? DSShadowsFoundations.shadowSmall
        : const <BoxShadow>[];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: enabled ? bgColor : DSColorsFoundations.buttonDisabled,
        borderRadius: BorderRadius.circular(
          borderRadius ?? DSRadiusFoundations.radiusMD,
        ),
        border: Border.all(
          color: enabled ? brdColor : brdColor.withValues(alpha: 0.4),
          width: isSelected ? 2 : 1,
        ),
        boxShadow: shadow,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(
          borderRadius ?? DSRadiusFoundations.radiusMD,
        ),
        onTap: enabled ? onPressed : null,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: DSSizesFoundations.separatorMedium,
            vertical: DSSizesFoundations.separatorSmall,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo + Texto
              Row(
                children: [
                  if (logo != null) ...[
                    SizedBox(
                      height: DSSizesFoundations.iconSizeLarge,
                      child: logo!,
                    ),
                    const SizedBox(width: 12),
                  ],
                  Text(
                    label,
                    style: DSTypographyFoundations.labelLarge.copyWith(
                      color: enabled
                          ? txtColor
                          : DSColorsFoundations.textHintDark,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w500,
                    ),
                  ),
                ],
              ),
              // Icono de selección o flecha
              if (trailingIcon != null)
                Icon(
                  trailingIcon,
                  color: enabled
                      ? (isSelected
                            ? (isDark
                                  ? DSColorsFoundations.brandPrimaryDark
                                  : DSColorsFoundations.brandPrimary)
                            : txtColor)
                      : DSColorsFoundations.textHint,
                  size: DSSizesFoundations.iconSizeSmall,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
