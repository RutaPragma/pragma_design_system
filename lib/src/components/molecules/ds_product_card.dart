import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/components/atoms/atoms.dart';
import 'package:pragma_design_system/src/foundations/foundations.dart';
import 'package:pragma_design_system/src/utils/enums.dart';

/// Molécula: DSProductCard
///
/// Tarjeta de producto para e-commerce, muestra imagen, título, precio, badge y botón de acción.
/// Altamente personalizable en colores, tamaños y contenido.
///
/// Ejemplo de uso:
/// ```dart
/// DSProductCard(
///   imageUrl: 'https://miapp.com/img/producto.png',
///   title: 'Camiseta Flutter',
///   price: '29.900',
///   badgeText: 'Nuevo',
///   onAddPressed: () => print('Agregar al carrito'),
/// )
/// ```
class DSProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String? badgeText;
  final VoidCallback? onAddPressed;
  final VoidCallback? onTapPressed;
  final double borderRadius;
  final bool showShadow;
  final bool showImageTopSpacing;
  final Widget? footer;

  final String buttonLabel;
  final double cardSize; // 🔹 Nuevo parámetro proporcional base

  // Personalización opcional
  final Color? bgColor;
  final Color? textColor;
  final Color? badgeBackgroundColor;
  final Color? badgeTextColor;
  final bool? isMedal;
  final double badgeSize;

  final Color? priceColor;
  final TextStyle? priceTextStyle;

  final Color? btnBackgroundColor;
  final Color? btnTextColor;
  final BoxFit boxFitImage;

  const DSProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.badgeText,
    this.onAddPressed,
    this.onTapPressed,
    this.borderRadius = DSRadiusFoundations.radiusMD,
    this.showShadow = true,
    this.footer,
    this.bgColor,
    this.textColor,
    this.badgeBackgroundColor,
    this.badgeTextColor,
    this.isMedal,
    this.badgeSize = 24,
    this.buttonLabel = "Agregar",
    this.priceColor,
    this.priceTextStyle,
    this.btnBackgroundColor,
    this.btnTextColor,
    this.cardSize = 100,
    this.boxFitImage = BoxFit.fill,
    this.showImageTopSpacing = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final effectiveBgColor =
        bgColor ??
        (isDark
            ? DSColorsFoundations.surfaceDark
            : DSColorsFoundations.surfaceLight);

    final effectiveTextColor =
        textColor ??
        (isDark
            ? DSColorsFoundations.textPrimaryDark
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

    final effectivePriceColor =
        priceColor ??
        (isDark
            ? DSColorsFoundations.brandPrimaryDark
            : DSColorsFoundations.brandPrimary);

    final effectivePriceTextStyle =
        priceTextStyle ??
        DSTypographyFoundations.bodySmall.copyWith(
          color: effectivePriceColor,
          fontWeight: FontWeight.bold,
        );

    final width = cardSize * 1.8;
    final heigth = cardSize * 3;
    return Card(
      key: const ValueKey("dsProductCardRoot"),
      elevation: 2,
      child: Container(
        key: const ValueKey("dsProductCardContainer"),
        width: width,
        height: heigth,
        decoration: BoxDecoration(
          color: effectiveBgColor,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: showShadow ? DSShadowsFoundations.shadowMedium : const [],
        ),
        clipBehavior: Clip.antiAlias,
        child: GestureDetector(
          key: const ValueKey("dsProductCardTapArea"),
          onTap: onTapPressed,
          child: SizedBox(
            key: const ValueKey("dsProductCardSizedBox"),
            height: double.infinity,
            width: double.infinity,
            child: Stack(
              key: const ValueKey("dsProductCardStack"),
              children: [
                Positioned(
                  key: const ValueKey("dsProductCardImagePosition"),
                  top: showImageTopSpacing ? 10 : 0,
                  left: 0,
                  right: 0,
                  bottom: 100,
                  child: Image.network(
                    key: const ValueKey("dsProductCardImage"),
                    imageUrl,
                    fit: boxFitImage,
                    loadingBuilder:
                        (
                          BuildContext context,
                          Widget child,
                          ImageChunkEvent? loadingProgress,
                        ) {
                          if (loadingProgress == null) return child;
                          return const DSLoader(
                            key: ValueKey("dsProductCardImageLoader"),
                          );
                        },
                  ),
                ),
                Positioned(
                  key: const ValueKey("dsProductCardTitlePosition"),
                  bottom: 60,
                  left: 10,
                  right: 10,
                  child: Text(
                    key: const ValueKey("dsProductCardTitle"),
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: DSTypographyFoundations.bodyMedium.copyWith(
                      color: effectiveTextColor,
                    ),
                  ),
                ),
          
                Positioned(
                  key: const ValueKey("dsProductCardPricePosition"),
                  bottom: 40,
                  left: 10,
                  child: Text(
                    price,
                    key: const ValueKey("dsProductCardPriceText"),
                    style: effectivePriceTextStyle,
                  ),
                ),

                Positioned(
                  key: const ValueKey("dsProductCardButtonPosition"),
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: DSButton(
                    key: const ValueKey("dsProductCardButton"),
                    label: buttonLabel,
                    onPressed: onAddPressed,
                    backgroundColor: btnBackgroundColor,
                    textColor: btnTextColor,
                    size: DSSize.xs,
                    radius: DSSizeRadius.large,
                    customHeigth: 26,
                  ),
                ),
                if (badgeText != null)
                  Positioned(
                    key: const ValueKey("dsProductCardBadgePosition"),
                    top: 5,
                    left: 5,
                    child: DSBadge(
                      key: const ValueKey("dsProductCardBadge"),
                      label: badgeText!,
                      backgroundColor: effectiveBadgeBg,
                      textColor: effectiveBadgeText,
                      isMedal: isMedal ?? true,
                      size: badgeSize,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
