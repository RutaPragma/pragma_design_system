import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/tokens/ds_typography.dart';
import 'package:pragma_design_system/src/tokens/ds_colors.dart';

///
/// Fundaciones de tipografía del sistema de diseño.
/// Esta capa conecta los estilos de [DSTypography] con
/// los propósitos semánticos
/// 
/// Cada estilo está pensado para su uso contextual:
/// títulos, precios, etiquetas, estados o descripciones.
class DSTypographyFoundations {
  DSTypographyFoundations._();

  // Headings / Títulos principales
  static const TextStyle displayXL = DSTypography.displayXLBold;
  static const TextStyle displayLarge = DSTypography.displayLargeBold;
  static const TextStyle displayMedium = DSTypography.displayMediumW600;
  static const TextStyle displaySmall = DSTypography.displaySmallW500;
  static const TextStyle displayXS = DSTypography.displayXSNormal;

  // Subtítulos / Secciones secundarias
  static const TextStyle subtitleXL = DSTypography.displayLargeW600;
  static const TextStyle subtitleLarge = DSTypography.displayMediumW600;
  static const TextStyle subtitleMedium = DSTypography.displaySmallW600;
  static const TextStyle subtitleSmall = DSTypography.displayXSNormal;

  // Texto de cuerpo / descripciones
  static const TextStyle bodyXL = DSTypography.displayLargeNormal;
  static const TextStyle bodyLarge = DSTypography.displayMediumNormal;
  static const TextStyle bodyMedium = DSTypography.displaySmallNormal;
  static const TextStyle bodySmall = DSTypography.displayXSNormal;

  // Labels / botones / badges
  static const TextStyle labelXL = DSTypography.displayLargeW600;
  static const TextStyle labelLarge = DSTypography.displayMediumW600;
  static const TextStyle labelMedium = DSTypography.displaySmallW600;
  static const TextStyle labelSmall = DSTypography.displayXSW600;

  //Textos de precio o descuento
  static final TextStyle price = DSTypography.displayLargeBold.copyWith(
    color: DSColors.brandPrimary,
  );

  static final TextStyle discount = DSTypography.displaySmallW600.copyWith(
    color: DSColors.error,
  );

  static final TextStyle oldPrice = DSTypography.displaySmallNormal.copyWith(
    color: DSColors.textHint,
    decoration: TextDecoration.lineThrough,
  );

  // Captions / Hints / Detalles
  static const TextStyle caption = DSTypography.displayXSNormal;
  static final TextStyle hint = DSTypography.displayXSNormal.copyWith(
    color: DSColors.textHint,
  );

  static final TextStyle overline = DSTypography.displayXSNormal.copyWith(
    letterSpacing: 1.2,
    color: DSColors.textSecondary,
    fontWeight: FontWeight.w500,
  );

  // Botones
  static const TextStyle buttonPrimary = DSTypography.displaySmallW600;
  static const TextStyle buttonSecondary = DSTypography.displaySmallW500;
  static const TextStyle buttonDisabled = DSTypography.displaySmallNormal;

  // Enlaces / Links
  static final TextStyle link = DSTypography.displaySmallW500.copyWith(
    color: DSColors.brandSecondary,
    decoration: TextDecoration.underline,
  );

  // Textos específicos de e-commerce
  static final TextStyle productTitle = DSTypography.displayMediumBold;
  static final TextStyle productDescription = DSTypography.displaySmallNormal;
  static final TextStyle productCategory = DSTypography.displayXSNormal.copyWith(
    color: DSColors.textSecondary,
  );

  // Navegación
  static const TextStyle navItem = DSTypography.displaySmallW600;
  static const TextStyle navItemActive = DSTypography.displaySmallBold;
}