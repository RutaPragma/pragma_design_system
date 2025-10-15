import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/foundations/foundations.dart';
import 'package:pragma_design_system/src/utils/enums.dart';

/// Átomo de botón base del sistema de diseño.
///
/// Este botón implementa variantes primarias, secundarias y deshabilitadas.
/// Su estructura visual depende de las *foundations* de colores, tamaños y radios.
///
/// Ejemplo de uso:
/// ```dart
/// DSButton(
///   label: 'Agregar al carrito',
///   onPressed: () {},
///   variant: DSButtonVariant.primary,
///   size: DSSize.medium,
/// )
/// ```
class DSButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final DSButtonVariant variant;
  final DSSize size;
  final bool isFullWidth;
  final Widget? icon;
  final DSSizeRadius radius;
  final DSButtonIconDirection iconDirection;

  const DSButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = DSButtonVariant.primary,
    this.size = DSSize.medium,
    this.isFullWidth = true,
    this.radius = DSSizeRadius.none,
    this.iconDirection = DSButtonIconDirection.left,
    this.icon,
  });

  // ===== Tamaño estándar del botón =====
  double _getHeight() {
    switch (size) {
      case DSSize.xs:
        return DSSizesFoundations.buttonHeightXS;
      case DSSize.small:
        return DSSizesFoundations.buttonHeightSmall;
      case DSSize.medium:
        return DSSizesFoundations.buttonHeightMedium;
      case DSSize.large:
        return DSSizesFoundations.buttonHeightLarge;
      case DSSize.xl:
        return DSSizesFoundations.buttonHeightXL;
    }
  }

  // ===== Tipografía por tamaño =====
  TextStyle _getTextStyle() {
    switch (size) {
      case DSSize.xs:
        return DSTypographyFoundations.labelSmall;
      case DSSize.small:
        return DSTypographyFoundations.labelSmall;
      case DSSize.medium:
        return DSTypographyFoundations.labelMedium;
      case DSSize.large:
        return DSTypographyFoundations.labelLarge;
      case DSSize.xl:
        return DSTypographyFoundations.labelXL;
    }
  }

  // ===== Colores por variante =====
  Color _getBackgroundColor(bool isDark) {
    switch (variant) {
      case DSButtonVariant.primary:
        return isDark
            ? DSColorsFoundations.buttonPrimaryDark
            : DSColorsFoundations.buttonPrimary;
      case DSButtonVariant.secondary:
        return isDark
            ? DSColorsFoundations.buttonSecondaryDark
            : DSColorsFoundations.buttonSecondary;
      case DSButtonVariant.disabled:
        return isDark
            ? DSColorsFoundations.buttonDisabledDark
            : DSColorsFoundations.buttonDisabled;
    }
  }

  Color _getTextColor(bool isDark) {
    switch (variant) {
      case DSButtonVariant.primary:
        return isDark
            ? DSColorsFoundations.buttonOnPrimaryDark
            : DSColorsFoundations.buttonOnPrimary;
      case DSButtonVariant.secondary:
        return isDark
            ? DSColorsFoundations.buttonOnSecondaryDark
            : DSColorsFoundations.buttonOnSecondary;
      case DSButtonVariant.disabled:
        return isDark
            ? DSColorsFoundations.buttonOnDisabledDark
            : DSColorsFoundations.buttonOnDisabled;
    }
  }

  double _getRadius() {
    switch (radius) {
      case DSSizeRadius.xs:
        return DSRadiusFoundations.radiusXS;
      case DSSizeRadius.small:
        return DSRadiusFoundations.radiusSM;
      case DSSizeRadius.medium:
        return DSRadiusFoundations.radiusMD;
      case DSSizeRadius.large:
        return DSRadiusFoundations.radiusLG;
      case DSSizeRadius.xl:
        return DSRadiusFoundations.radiusXL;
      case DSSizeRadius.radiusCircular:
        return DSRadiusFoundations.radiusCircular;
      default:
        return DSRadiusFoundations.none;
    }
  }

  BorderSide? _getBorder(bool isDark) {
    if (variant == DSButtonVariant.secondary) {
      return BorderSide(
        color: isDark
            ? DSColorsFoundations.buttonSecondaryDark
            : DSColorsFoundations.buttonSecondary,
        width: 1.5,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bool isDisabled =
        variant == DSButtonVariant.disabled || onPressed == null;

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: _getHeight(),
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(_getBackgroundColor(isDark)),
          foregroundColor: WidgetStatePropertyAll(_getTextColor(isDark)),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_getRadius()),
              side: _getBorder(isDark) ?? BorderSide.none,
            ),
          ),
          elevation: const WidgetStatePropertyAll(0),
          padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(
              horizontal: DSSizesFoundations.separatorMedium,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            if (iconDirection == DSButtonIconDirection.left &&
                icon != null) ...[
              icon!,
              SizedBox(width: DSSizesFoundations.separatorSmall),
            ],
            Text(
              label,
              style: _getTextStyle().copyWith(color: _getTextColor(isDark)),
            ),

            if (iconDirection == DSButtonIconDirection.rigth &&
                icon != null) ...[
              icon!,
              SizedBox(width: DSSizesFoundations.separatorSmall),
            ],
          ],
        ),
      ),
    );
  }
}
