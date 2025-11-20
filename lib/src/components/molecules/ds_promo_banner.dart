import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/components/atoms/atoms.dart';
import 'package:pragma_design_system/src/foundations/foundations.dart';
import 'package:pragma_design_system/src/utils/enums.dart' show DSSize;

/// Molécula: DSPromoBanner
///
/// Banner promocional para mostrar ofertas, novedades o mensajes destacados.
/// Permite personalizar imagen, badge, botón y colores.
///
/// Ejemplo de uso:
/// ```dart
/// DSPromoBanner(
///   title: '¡Oferta especial!',
///   subtitle: 'Solo por hoy',
///   imageUrl: 'https://miapp.com/img/oferta.png',
///   badgeText: 'Nuevo',
///   buttonLabel: 'Ver más',
///   onPressed: () => print('Ver oferta'),
/// )
/// ```
class DSPromoBanner extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? imageUrl;
  final String? badgeText;
  final String? buttonLabel;
  final VoidCallback? onPressed;
  final bool isReversed;
  final double size;
  final Color? backgroundColor;
  final Color? textColor;

  const DSPromoBanner({
    super.key,
    required this.title,
    this.subtitle,
    this.imageUrl,
    this.badgeText,
    this.buttonLabel,
    this.onPressed,
    this.isReversed = false,
    this.size = 140,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bg =
        backgroundColor ??
        (isDark
            ? DSColorsFoundations.surfaceDark
            : DSColorsFoundations.surfaceLight);
    final txtColor =
        textColor ??
        (isDark
            ? DSColorsFoundations.textPrimaryDark
            : DSColorsFoundations.textPrimary);

    final content = Expanded(
      key: const ValueKey("dsPromoBannerContent"),
      flex: 2,
      child: Padding(
        key: const ValueKey("dsPromoBannerContentPadding"),
        padding: EdgeInsets.all(DSSizesFoundations.separatorMedium),
        child: Column(
          key: const ValueKey("dsPromoBannerContentColumn"),
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (badgeText != null)
              Padding(
                key: const ValueKey("dsPromoBannerBadgePadding"),
                padding: EdgeInsets.only(
                  bottom: DSSizesFoundations.separatorSmall,
                ),
                child: DSBadge(
                  key: const ValueKey("dsPromoBannerBadge"),
                  label: badgeText!,
                  isMedal: true,
                  backgroundColor: DSColorsFoundations.brandPrimary,
                  textColor: DSColorsFoundations.textOnPrimary,
                ),
              ),
            Text(
              key: const ValueKey("dsPromoBannerTitle"),
              title,
              style: DSTypographyFoundations.displaySmall.copyWith(
                color: txtColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 6),
              Text(
                key: const ValueKey("dsPromoBannerSubtitle"),
                subtitle!,
                style: DSTypographyFoundations.bodyMedium.copyWith(
                  color: txtColor.withValues(alpha: 0.8),
                ),
              ),
            ],
            if (buttonLabel != null && onPressed != null) ...[
              const SizedBox(height: 12),
              DSButton(
                key: const ValueKey("dsPromoBannerButton"),
                label: buttonLabel!,
                onPressed: onPressed,
                size: DSSize.small,
                isFullWidth: false,
                backgroundColor: DSColorsFoundations.brandPrimary,
                textColor: DSColorsFoundations.textOnPrimary,
                customHeigth: 40,
                customWidth: 98,
              ),
            ],
          ],
        ),
      ),
    );

    final image = Expanded(
      key: const ValueKey("dsPromoBannerImageExpanded"),
      flex: 3,
      child: ClipRRect(
        key: const ValueKey("dsPromoBannerClipRRect"),
        borderRadius: BorderRadius.circular(DSRadiusFoundations.radiusMD),
        child: Image.network(
          key: const ValueKey("dsPromoBannerImage"),
          imageUrl ?? "",
          fit: BoxFit.cover,
          loadingBuilder:
              (
                BuildContext context,
                Widget child,
                ImageChunkEvent? loadingProgress,
              ) {
                if (loadingProgress == null) return child;
                return const DSLoader(
                  key: ValueKey("dsPromoBannerImageLoader"),
                );
              },

          height: size,
          errorBuilder: (_, __, ___) => Container(
            key: const ValueKey("dsPromoBannerImageError"),
            color: Colors.grey.shade200,
          ),
        ),
      ),
    );

    return Container(
      key: const ValueKey("dsPromoBannerContainer"),
      height: size,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(DSRadiusFoundations.radiusXL),
        boxShadow: DSShadowsFoundations.shadowMedium,
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        key: const ValueKey("dsPromoBannerRow"),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: isReversed ? [image, content] : [content, image],
      ),
    );
  }
}
