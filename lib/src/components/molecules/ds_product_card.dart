import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/components/atoms/atoms.dart';
import 'package:pragma_design_system/src/foundations/foundations.dart';
import 'package:pragma_design_system/src/utils/enums.dart';

class DSProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String? badgeText;
  final VoidCallback? onPressed;
  final double borderRadius;
  final bool showShadow;
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
    this.onPressed,
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
      elevation: 4,
      child: Container(
        width: width,
        height: heigth,
        decoration: BoxDecoration(
          color: effectiveBgColor,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: showShadow ? DSShadowsFoundations.shadowMedium : const [],
        ),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 100,
                child: Image.network(
                  imageUrl,
                  fit: boxFitImage,
                  loadingBuilder:
                      (
                        BuildContext context,
                        Widget child,
                        ImageChunkEvent? loadingProgress,
                      ) {
                        if (loadingProgress == null) return child;
                        return DSLoader();
                      },
                ),
              ),
              Positioned(
                bottom: 60,
                left: 10,
                right: 10,
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: DSTypographyFoundations.bodyMedium.copyWith(
                    color: effectiveTextColor,
                  ),
                ),
              ),

              Positioned(
                bottom: 40,
                left: 10,
                child: Text(price, style: effectivePriceTextStyle),
              ),

              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: DSButton(
                  label: buttonLabel,
                  onPressed: onPressed,
                  backgroundColor: btnBackgroundColor,
                  textColor: btnTextColor,
                  size: DSSize.xs,
                  radius: DSSizeRadius.large,
                  customHeigth: 26,
                ),
              ),
              if (badgeText != null)
                Positioned(
                  top: 5,
                  left: 5,
                  child: DSBadge(
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
    );
  }
}
