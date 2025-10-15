import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/foundations/ds_colors_foundation.dart';
import 'package:pragma_design_system/src/foundations/ds_sizes_foundations.dart';
import 'package:pragma_design_system/src/foundations/ds_radius_foundations.dart';
import 'package:pragma_design_system/src/foundations/ds_shadows_foundations.dart';
import 'package:pragma_design_system/src/utils/enums.dart';

/// Átomo: DSIconButton
///
/// Botón de ícono adaptable a variantes (primary, secondary, disabled).
/// Ideal para acciones rápidas: "favorito", "buscar", "editar", etc.
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

  double _getSize() {
    switch (size) {
      case DSSize.xs:
        return DSSizesFoundations.iconSizeXS * 1.2;
      case DSSize.small:
        return DSSizesFoundations.iconSizeSmall * 1.3;
      case DSSize.medium:
        return DSSizesFoundations.iconSizeMedium * 1.4;
      case DSSize.large:
        return DSSizesFoundations.iconSizeLarge * 1.8;
      case DSSize.xl:
        return DSSizesFoundations.iconSizeXL * 1.8;
    }
  }

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
    final double dimension = _getSize();
    final bool isDisabled =
        variant == DSIconButtonVariant.disabled || onPressed == null;

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      borderRadius: BorderRadius.circular(
        isCircular ? customSize ?? dimension / 2 : DSRadiusFoundations.radiusSM,
      ),
      onTap: isDisabled ? null : onPressed,
      child: Container(
        height: customSize ?? dimension,
        width: customSize ?? dimension,
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
          icon,
          color: disabled
              ? DSColorsFoundations.textHint
              : _getIconColor(isDark),
          size: (customSize ?? _getSize()) * 0.8,
        ),
      ),
    );
  }
}
