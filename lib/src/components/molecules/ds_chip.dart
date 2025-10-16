import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/components/atoms/atoms.dart';
import 'package:pragma_design_system/src/foundations/foundations.dart';

/// Molécula: DSChip
///
/// Un chip flexible que puede representar categorías, etiquetas o estados.
/// Soporta ícono opcional, selección, y colores personalizables.
///
/// Ejemplo:
/// ```dart
/// DSChip(
///   label: "Flutter",
///   icon: Icons.flutter_dash,
///   selected: true,
///   onTap: () => print("Chip seleccionado"),
/// )
/// ```
class DSChip extends StatefulWidget {
  final String label;
  final IconData? icon;
  final bool selected;
  final bool enabled;
  final VoidCallback? onTap;

  /// Colores personalizables
  final Color? backgroundColor;
  final Color? textColor;
  final Color? selectedColor;
  final Color? selectedTextColor;
  final Color? borderColor;

  /// Tamaños y bordes
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;

  const DSChip({
    super.key,
    required this.label,
    this.icon,
    this.selected = false,
    this.enabled = true,
    this.onTap,
    this.backgroundColor,
    this.textColor,
    this.selectedColor,
    this.selectedTextColor,
    this.borderColor,
    this.borderRadius,
    this.padding,
  });

  @override
  State<DSChip> createState() => _DSChipState();
}

class _DSChipState extends State<DSChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bgColor = widget.selected
        ? (widget.selectedColor ??
              (isDark
                  ? DSColorsFoundations.brandPrimaryDark
                  : DSColorsFoundations.brandPrimary))
        : (widget.backgroundColor ??
              (isDark
                  ? DSColorsFoundations.surfaceDark
                  : DSColorsFoundations.surfaceLight));

    final txtColor = widget.selected
        ? (widget.selectedTextColor ??
              (isDark
                  ? DSColorsFoundations.textOnPrimaryDark
                  : DSColorsFoundations.textOnPrimary))
        : (widget.textColor ??
              (isDark
                  ? DSColorsFoundations.textPrimaryDark
                  : DSColorsFoundations.textPrimary));

    final borderClr =
        widget.borderColor ??
        (isDark
            ? DSColorsFoundations.inputBorderDark
            : DSColorsFoundations.inputBorder);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.enabled ? widget.onTap : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          padding:
              widget.padding ??
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: widget.enabled
                ? (_isHovered ? bgColor.withValues(alpha: 0.85) : bgColor)
                : DSColorsFoundations.buttonDisabled,
            borderRadius: BorderRadius.circular(
              widget.borderRadius ?? DSRadiusFoundations.radiusCircular,
            ),
            border: Border.all(
              color: widget.enabled
                  ? borderClr
                  : borderClr.withValues(alpha: 0.4),
              width: 1,
            ),
            boxShadow: _isHovered ? DSShadowsFoundations.shadowSmall : const [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                DSIcon(
                  icon: widget.icon!,
                  customColor: txtColor,
                  customSize: DSSizesFoundations.iconSizeSmall,
                ),
                const SizedBox(width: 6),
              ],
              Text(
                widget.label,
                style: DSTypographyFoundations.labelMedium.copyWith(
                  color: txtColor,
                  fontWeight: widget.selected
                      ? FontWeight.w600
                      : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
