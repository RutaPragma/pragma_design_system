import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/foundations/foundations.dart';
import 'package:pragma_design_system/src/utils/enums.dart';
import 'package:pragma_design_system/src/utils/helpers.dart';

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
///   backgroundColor: Colors.red,
///   textColor: Colors.white,
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
  final DSSpacin elevation;
  final double? customHeigth;
  final double? customWidth;

  /// Personalización de colores
  final Color? backgroundColor;
  final Color? textColor;

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
    this.elevation = DSSpacin.none,
    this.backgroundColor,
    this.textColor,
    this.customHeigth,
    this.customWidth,
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
    if (backgroundColor != null) return backgroundColor!;
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
    if (textColor != null) return textColor!;
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

    final Color effectiveBackground = _getBackgroundColor(isDark);
    final Color effectiveTextColor = _getTextColor(isDark);

    return ConstrainedBox(
      key: const ValueKey("dsButtonConstrainedBox"),
      constraints: BoxConstraints(
        minWidth: 0,
        maxWidth:
            customWidth ?? (isFullWidth ? double.infinity : double.maxFinite),
      ),
      child: SizedBox(
        key: const ValueKey("dsButtonSizedBox"),
        height: customHeigth ?? _getHeight(),
        child: ElevatedButton(
          key: const ValueKey("dsButtonElevatedButton"),
          onPressed: isDisabled ? null : onPressed,
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(effectiveBackground),
            foregroundColor: WidgetStatePropertyAll(effectiveTextColor),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(getDSRadius(radius)),
                side: _getBorder(isDark) ?? BorderSide.none,
              ),
            ),
            elevation: WidgetStatePropertyAll(getDSElevation(elevation)),
            padding: WidgetStatePropertyAll(
              EdgeInsets.symmetric(
                horizontal: DSSizesFoundations.separatorMedium,
              ),
            ),
          ),
          child: FittedBox(
            key: const ValueKey("dsButtonFittedBox"),
            fit: BoxFit.scaleDown,
            child: Row(
              key: const ValueKey("dsButtonContentRow"),
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (iconDirection == DSButtonIconDirection.left &&
                    icon != null) ...[
                  icon!,
                  SizedBox(width: DSSizesFoundations.separatorSmall),
                ],
                Flexible(
                  child: Text(
                    key: const ValueKey("dsButtonLabel"),
                    label,
                    overflow: TextOverflow.ellipsis,
                    style: _getTextStyle().copyWith(color: effectiveTextColor),
                  ),
                ),
                if (iconDirection == DSButtonIconDirection.rigth &&
                    icon != null) ...[
                  SizedBox(width: DSSizesFoundations.separatorSmall),
                  icon!,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
