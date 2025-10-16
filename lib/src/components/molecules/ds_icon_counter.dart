import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/components/atoms/atoms.dart';
import 'package:pragma_design_system/src/foundations/foundations.dart';

/// Molécula: DSIconCounter
///
/// Este componente muestra un ícono (por ejemplo, carrito o notificación)
/// con un contador tipo badge. Ideal para e-commerce.
///
/// - Usa DSIcon y DSBadge
/// - Respeta el modo claro/oscuro
/// - Altamente configurable para tamaño, colores, forma y comportamiento
class DSIconCounter extends StatelessWidget {
  final IconData icon;
  final int count;
  final VoidCallback? onTap;

  /// Colores personalizables
  final Color? iconColor;
  final Color? badgeBackgroundColor;
  final Color? badgeTextColor;

  /// Tamaños y estilos
  final double? iconSize;
  final bool showBadge;
  final bool isMedal;
  final double? badgeSize;
  final double? badgeTextSize;

  const DSIconCounter({
    super.key,
    required this.icon,
    this.count = 0,
    this.onTap,
    this.iconColor,
    this.badgeBackgroundColor,
    this.badgeTextColor,
    this.iconSize,
    this.showBadge = true,
    this.isMedal = false,
    this.badgeSize = 20,
    this.badgeTextSize = 9,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final effectiveIconColor =
        iconColor ??
        (isDark
            ? DSColorsFoundations.brandSecondaryDark
            : DSColorsFoundations.textPrimary);

    final effectiveBadgeBg =
        badgeBackgroundColor ??
        (isDark
            ? DSColorsFoundations.brandPrimaryDark
            : DSColorsFoundations.brandPrimary);

    final effectiveBadgeText =
        badgeTextColor ??
        (isDark
            ? DSColorsFoundations.textOnPrimaryDark
            : DSColorsFoundations.textOnPrimary);

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Icono base
          DSIcon(
            icon: icon,
            customColor: effectiveIconColor,
            customSize: iconSize ?? DSSizesFoundations.iconSizeLarge,
          ),

          // Badge contador
          if (showBadge && count > 0)
            Positioned(
              right: -6,
              top: -6,
              child: DSBadge(
                size: badgeSize,
                textSize: badgeTextSize,
                label: count > 99 ? "99+" : count.toString(),
                backgroundColor: effectiveBadgeBg,
                textColor: effectiveBadgeText,
                isMedal: isMedal,
              ),
            ),
        ],
      ),
    );
  }
}
