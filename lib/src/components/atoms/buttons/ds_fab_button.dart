import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/foundations/foundations.dart';
import 'package:pragma_design_system/src/utils/enums.dart';

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

  const DSFabButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.label,
    this.extended = false,
    this.variant = DSFabVariant.primary,
  });

  Color _getBackgroundColor() {
    switch (variant) {
      case DSFabVariant.primary:
        return DSColorsFoundations.brandPrimary;
      case DSFabVariant.secondary:
        return DSColorsFoundations.brandSecondary;
    }
  }

  Color _getForegroundColor() {
    switch (variant) {
      case DSFabVariant.primary:
        return DSColorsFoundations.textOnPrimary;
      case DSFabVariant.secondary:
        return DSColorsFoundations.textOnSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      backgroundColor: _getBackgroundColor(),
      foregroundColor: _getForegroundColor(),
      elevation: .0,
      icon: Icon(icon, size: DSSizesFoundations.iconSizeLarge),

      label: extended
          ? Text(
              label ?? '',
              style: DSTypographyFoundations.displayLarge.copyWith(
                color: _getForegroundColor(),
              ),
            )
          : const SizedBox.shrink(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DSRadiusFoundations.radiusXL),
      ),
      // Si no es extendido, usamos el FAB circular tradicional.
      isExtended: extended,
    );
  }
}
