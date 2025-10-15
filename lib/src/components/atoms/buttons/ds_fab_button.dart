import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// Átomo: DSFabButton
///
/// Floating Action Button del sistema de diseño.
/// Ideal para acciones principales (por ejemplo: agregar al carrito, iniciar chat, etc.)
class DSFabButton extends StatelessWidget {
  final IconData icon;
  final String? label;
  final VoidCallback onPressed;
  final bool extended;
  final DSFabVariant variant;
  final DSSizeRadius radius;
  final DSSpacin elevation;
  final DSSize size;
  final double? customSize;

  const DSFabButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.label,
    this.extended = false,
    this.variant = DSFabVariant.primary,
    this.radius = DSSizeRadius.none,
    this.elevation = DSSpacin.none,
    this.size = DSSize.medium,
    this.customSize,
  });

  Color _getBackgroundColor(bool isDark) {
    switch (variant) {
      case DSFabVariant.primary:
        return isDark
            ? DSColorsFoundations.brandPrimaryDark
            : DSColorsFoundations.brandPrimary;
      case DSFabVariant.secondary:
        return isDark
            ? DSColorsFoundations.brandSecondaryDark
            : DSColorsFoundations.brandSecondary;
    }
  }

  Color _getForegroundColor(bool isDark) {
    switch (variant) {
      case DSFabVariant.primary:
        return isDark
            ? DSColorsFoundations.textOnPrimaryDark
            : DSColorsFoundations.textOnPrimary;
      case DSFabVariant.secondary:
        return isDark
            ? DSColorsFoundations.textOnSecondaryDark
            : DSColorsFoundations.textOnSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final double dimension = getDsSizeIconButton(size);

    return Container(
      alignment: AlignmentGeometry.center,
      height: dimension,
      width: dimension,

      decoration: BoxDecoration(boxShadow: DSShadowsFoundations.shadowSmall),

      child: FloatingActionButton.large(
        onPressed: onPressed,
        backgroundColor: _getBackgroundColor(isDark),
        foregroundColor: _getForegroundColor(isDark),
        elevation: getDSElevation(elevation),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(getDSRadius(radius)),
        ),
        child: Center(
          child: Icon(
            icon,
            size: (customSize ?? getDsSizeIconButton(size)) * 0.6,
          ),
        ),
      ),
    );
  }
}
