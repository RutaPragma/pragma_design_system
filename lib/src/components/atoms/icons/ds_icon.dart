import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/foundations/ds_colors_foundation.dart';
import 'package:pragma_design_system/src/foundations/ds_sizes_foundations.dart';
import 'package:pragma_design_system/src/utils/enums.dart';

/// Átomo de íconos del sistema de diseño.
///
/// Este componente encapsula la lógica visual de los íconos, asegurando
/// consistencia en tamaños, colores y estilos según las definiciones de
/// *foundations*.
///
/// Ejemplo:
/// ```dart
/// const DSIcon(
///   icon: Icons.shopping_cart,
///   size: DSSize.medium,
///   color: DSIconColor.primary,
///   disabled: false,
/// )
/// ```
class DSIcon extends StatelessWidget {
  const DSIcon({
    super.key,
    required this.icon,
    this.size = DSSize.medium,
    this.color = DSIconColor.primary,
    this.customSize,
    this.customColor,
    this.onPressed,
  });

  final IconData icon;
  final DSSize size;
  final DSIconColor color;
  final double? customSize;
  final Color? customColor;
  final bool disabled = false;
  final VoidCallback? onPressed;

  double _getSize() {
    switch (size) {
      case DSSize.xs:
        return DSSizesFoundations.iconSizeXS;
      case DSSize.small:
        return DSSizesFoundations.iconSizeSmall;
      case DSSize.medium:
        return DSSizesFoundations.iconSizeMedium;
      case DSSize.large:
        return DSSizesFoundations.iconSizeLarge;
      case DSSize.xl:
        return DSSizesFoundations.iconSizeXL;
    }
  }

  Color _getColor(bool isDark) {
    switch (color) {
      case DSIconColor.primary:
        return isDark
            ? DSColorsFoundations.textPrimaryDark
            : DSColorsFoundations.textPrimary;
      case DSIconColor.secondary:
        return isDark
            ? DSColorsFoundations.textSecondaryDark
            : DSColorsFoundations.textSecondary;
      case DSIconColor.onPrimary:
        return isDark
            ? DSColorsFoundations.textOnPrimaryDark
            : DSColorsFoundations.textOnPrimary;
      case DSIconColor.onSecondary:
        return isDark
            ? DSColorsFoundations.textOnSecondaryDark
            : DSColorsFoundations.textOnSecondary;
      case DSIconColor.disabled:
        return isDark
            ? DSColorsFoundations.textHintDark
            : DSColorsFoundations.textHint;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => onPressed?.call(),
      child: Icon(
        icon,
        size: customSize ?? _getSize(),
        color: disabled
            ? DSColorsFoundations.textHint
            : customColor ?? _getColor(isDark),
      ),
    );
  }
}
