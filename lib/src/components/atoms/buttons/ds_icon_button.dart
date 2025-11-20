import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// Átomo: DSIconButton
///
/// Botón de ícono adaptable a variantes (primary, secondary, disabled).
/// Ideal para acciones rápidas: "favorito", "buscar", "editar", etc.
///
/// Ejemplo de uso:
/// ```dart
/// DSIconButton(
///   icon: Icons.favorite,
///   onPressed: () => print('Favorito'),
///   variant: DSIconButtonVariant.primary,
///   size: DSSize.medium,
/// )
/// ```
class DSIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final DSIconButtonVariant variant;
  final DSSize size;
  final double? customSize;
  final Color? customColor;
  final bool isCircular;
  final bool disabled = false;

  const DSIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.variant = DSIconButtonVariant.primary,
    this.size = DSSize.medium,
    this.isCircular = true,
    this.customSize,
    this.customColor,
  });

  Color _getBackgroundColor(bool isDark) {
    switch (variant) {
      case DSIconButtonVariant.primary:
        return isDark
            ? DSColorsFoundations.buttonPrimaryDark
            : DSColorsFoundations.buttonPrimary;
      case DSIconButtonVariant.secondary:
        return isDark
            ? DSColorsFoundations.buttonSecondaryDark
            : DSColorsFoundations.buttonSecondary;
      case DSIconButtonVariant.disabled:
        return isDark
            ? DSColorsFoundations.buttonDisabledDark
            : DSColorsFoundations.buttonDisabled;
    }
  }

  Color _getIconColor(bool isDark) {
    switch (variant) {
      case DSIconButtonVariant.primary:
        return isDark
            ? DSColorsFoundations.buttonOnPrimaryDark
            : DSColorsFoundations.buttonOnPrimary;
      case DSIconButtonVariant.secondary:
        return isDark
            ? DSColorsFoundations.buttonOnSecondaryDark
            : DSColorsFoundations.buttonOnSecondary;
      case DSIconButtonVariant.disabled:
        return isDark
            ? DSColorsFoundations.buttonOnDisabledDark
            : DSColorsFoundations.buttonOnDisabled;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double dimension = getDsSizeIconButton(size);
    final bool isDisabled =
        variant == DSIconButtonVariant.disabled || onPressed == null;

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      key: const ValueKey("dsIconButtonInkWell"),
      borderRadius: BorderRadius.circular(
        isCircular ? customSize ?? dimension / 2 : DSRadiusFoundations.radiusSM,
      ),
      onTap: isDisabled ? null : onPressed,
      child: Container(
        key: const ValueKey("dsIconButtonContainer"),
        height: customSize ?? dimension,
        width: customSize ?? dimension,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: disabled
              ? DSColorsFoundations.buttonDisabled
              : customColor ?? _getBackgroundColor(isDark),
          borderRadius: BorderRadius.circular(
            isCircular
                ? customSize ?? dimension / 2
                : DSRadiusFoundations.radiusSM,
          ),
          boxShadow: DSShadowsFoundations.shadowSmall,
        ),
        child: Icon(
          key: const ValueKey("dsIconButtonIcon"),
          icon,
          color: disabled
              ? DSColorsFoundations.textHint
              : _getIconColor(isDark),
          size: (customSize ?? getDsSizeIconButton(size)) * 0.8,
        ),
      ),
    );
  }
}
