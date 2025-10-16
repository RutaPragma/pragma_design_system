import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/components/atoms/atoms.dart';
import 'package:pragma_design_system/src/foundations/foundations.dart';
import 'package:pragma_design_system/src/utils/utils.dart';

/// Muestra un banner promocional con imagen, texto, y botón de acción.
///
/// Soporta colores personalizados, disposición adaptable, y puede incluir un badge destacado.
class DSPromoBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? imageUrl;
  final String? badgeText;
  final String? buttonLabel;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final bool showShadow;
  final bool isReversed;
  final double borderRadius;
  final double size;

  const DSPromoBanner({
    super.key,
    required this.title,
    required this.subtitle,
    this.imageUrl,
    this.badgeText,
    this.buttonLabel,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.showShadow = true,
    this.isReversed = false,
    this.borderRadius = DSRadiusFoundations.radiusMD,
    this.size = 100,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bgColor =
        backgroundColor ??
        (isDark
            ? DSColorsFoundations.surfaceDark
            : DSColorsFoundations.surfaceLight);

    final txtColor =
        textColor ??
        (isDark
            ? DSColorsFoundations.textPrimaryDark
            : DSColorsFoundations.textPrimary);

    final children = [
      // Texto y botón
      Expanded(
        flex: 2,
        child: Padding(
          padding: EdgeInsets.all(DSSizesFoundations.separatorMedium),
          child: Wrap(
            children: [
              if (badgeText != null)
                DSBadge(
                  label: badgeText!,
                  isMedal: true,
                  backgroundColor: isDark
                      ? DSColorsFoundations.brandPrimaryDark
                      : DSColorsFoundations.brandPrimary,
                  textColor: DSColorsFoundations.textOnPrimary,
                ),
              SizedBox(height: 1),
              Text(
                title,
                style: DSTypographyFoundations.displaySmall.copyWith(
                  color: txtColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: DSTypographyFoundations.displaySmall.copyWith(
                  color: txtColor.withValues(alpha: 0.8),
                ),
              ),
              if (buttonLabel != null && onPressed != null)
                Padding(
                  padding: EdgeInsets.only(
                    top: DSSizesFoundations.separatorSmall,
                  ),
                  child: DSButton(
                    label: buttonLabel!,
                    onPressed: onPressed,
                    size: DSSize.xs,
                  ),
                ),
            ],
          ),
        ),
      ),

      // Imagen (con altura fija)
      if (imageUrl != null)
        Expanded(
          flex: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(borderRadius),
              bottomRight: Radius.circular(borderRadius),
            ),
            child: Image.network(
              imageUrl!,
              fit: BoxFit.fill,
              height: double.infinity,
            ),
          ),
        ),
    ];

    return Container(
      height: size,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: showShadow ? DSShadowsFoundations.shadowMedium : [],
      ),
      constraints: BoxConstraints(minHeight: 10, maxHeight: 160),
      clipBehavior: Clip.antiAlias,
      child: SizedBox.expand(
        child: Row(
          children: isReversed ? children.reversed.toList() : children,
        ),
      ),
    );
  }
}
