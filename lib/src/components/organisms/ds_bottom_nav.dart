import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/components/atoms/atoms.dart';
import 'package:pragma_design_system/src/foundations/foundations.dart';
import 'package:pragma_design_system/src/utils/enums.dart';

/// Organismo: Barra de navegación inferior moderna con soporte para animaciones,
/// badges personalizados (usando DSBadge), y colores adaptativos.
///
/// Altamente parametrizable y diseñada para integrarse con el sistema de diseño.
class DSBottomNav extends StatefulWidget {
  final List<DSBottomNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onItemSelected;

  // Personalización visual
  final Color? backgroundColor;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? badgeBackgroundColor;
  final Color? badgeTextColor;
  final double height;
  final double iconSize;
  final double borderRadius;
  final bool showLabels;
  final bool useElevation;

  const DSBottomNav({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onItemSelected,
    this.backgroundColor,
    this.activeColor,
    this.inactiveColor,
    this.badgeBackgroundColor,
    this.badgeTextColor,
    this.height = 68,
    this.iconSize = 26,
    this.borderRadius = DSRadiusFoundations.radiusXL,
    this.showLabels = true,
    this.useElevation = true,
  });

  @override
  State<DSBottomNav> createState() => _DSBottomNavState();
}

class _DSBottomNavState extends State<DSBottomNav> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bg =
        widget.backgroundColor ??
        (isDark
            ? DSColorsFoundations.surfaceDark
            : DSColorsFoundations.surfaceLight);

    final active =
        widget.activeColor ??
        (isDark
            ? DSColorsFoundations.brandSecondaryDark
            : DSColorsFoundations.brandSecondary);

    final inactive =
        widget.inactiveColor ??
        (isDark
            ? DSColorsFoundations.brandPrimaryDark
            : DSColorsFoundations.brandPrimary);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(widget.borderRadius),
        ),
        boxShadow: widget.useElevation ? DSShadowsFoundations.shadowMedium : [],
      ),
      height: widget.height,
      padding: EdgeInsets.symmetric(
        horizontal: DSSizesFoundations.separatorLarge,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(widget.items.length, (index) {
          final item = widget.items[index];
          var selected = index == widget.currentIndex;

          return Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(DSRadiusFoundations.radiusLG),
              splashColor: active..withValues(alpha: 0.1),
              onTap: () {
                widget.onItemSelected(index);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                padding: EdgeInsets.symmetric(
                  vertical: DSSizesFoundations.separatorSmall,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        DSIcon(
                          icon: item.icon,
                          customColor: selected ? active : inactive,
                          size: DSSize.medium,
                        ),
                        if (item.badgeCount != null && item.badgeCount! > 0)
                          Positioned(
                            right: -6,
                            top: -4,
                            child: DSBadge(
                              size: 16,
                              textSize: 9,
                              label: item.badgeCount! > 9
                                  ? '9+'
                                  : item.badgeCount.toString(),
                              isMedal: false,
                              backgroundColor:
                                  widget.badgeBackgroundColor ??
                                  DSColorsFoundations.error,
                              textColor:
                                  widget.badgeTextColor ??
                                  DSColorsFoundations.textOnPrimary,

                              // fontSize: 10,
                            ),
                          ),
                      ],
                    ),
                    if (widget.showLabels)
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: DSTypographyFoundations.labelSmall.copyWith(
                          color: selected ? active : inactive,
                          fontWeight: selected
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(item.label),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

/// Modelo para los ítems de navegación inferior.
class DSBottomNavItem {
  final IconData icon;
  final String label;
  final int? badgeCount;

  const DSBottomNavItem({
    required this.icon,
    required this.label,
    this.badgeCount,
  });
}
