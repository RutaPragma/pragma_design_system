import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// Showcase educativo que explica los **Tokens base** del Design System.
///
/// Los tokens representan valores puros: colores, tamaños, sombras, tipografía,
/// sin contexto semántico. Son la base de los *Foundations*.
class DSTokensShowcase extends StatelessWidget {
  const DSTokensShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark
        ? DSColorsFoundations.textPrimaryDark
        : DSColorsFoundations.textPrimary;

    return Scaffold(
      backgroundColor: isDark
          ? DSColorsFoundations.surfaceDark
          : DSColorsFoundations.surfaceLight,
      appBar: AppBar(
        title: const Text("Tokens"),
        backgroundColor: isDark
            ? DSColorsFoundations.surfaceDark
            : DSColorsFoundations.brandPrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle("1. DSColors", textColor),
          _buildDescription(
            "Valores hexadecimales que definen la paleta base del sistema.",
          ),
          _buildColorTokens(),

          _buildSectionTitle("2. DSRadius", textColor),
          _buildDescription(
            "Tokens de radios que definen las esquinas de los componentes.",
          ),
          _buildRadiusTokens(),

          _buildSectionTitle("3. DSShadows", textColor),
          _buildDescription(
            "Tokens que definen las elevaciones mediante sombras.",
          ),
          _buildShadowTokens(),

          _buildSectionTitle("4. DSSizes", textColor),
          _buildDescription(
            "Tokens de dimensiones estándar: íconos, botones, textos.",
          ),
          _buildSizeTokens(),

          _buildSectionTitle("5. DSSpacing", textColor),
          _buildDescription(
            "Tokens de espaciados utilizados para márgenes y paddings.",
          ),
          _buildSpacingTokens(),

          _buildSectionTitle("6. DSTypography", textColor),
          _buildDescription(
            "Tokens de tipografía base: familia, pesos y tamaños.",
          ),
          _buildTypographyTokens(),
        ],
      ),
    );
  }

  // ===== Secciones base =====
  Widget _buildSectionTitle(String title, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(
        title,
        style: DSTypographyFoundations.displaySmall.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDescription(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: DSTypographyFoundations.bodyMedium.copyWith(
          color: DSColorsFoundations.textSecondary,
        ),
      ),
    );
  }

  // ===== 1. COLORES =====
  Widget _buildColorTokens() {
    final colors = {
      "brandPrimary": DSColors.brandPrimary,
      "brandSecondary": DSColors.brandSecondary,
      "bgPrimary": DSColors.bgPrimary,
      "surfaceDark": DSColors.surfaceDark,
      "error": DSColors.error,
      "success": DSColors.success,
      "warning": DSColors.warning,
      "info": DSColors.info,
    };

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: colors.entries.map((entry) {
        return Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: entry.value,
            borderRadius: BorderRadius.circular(10),
            boxShadow: DSShadows.shadowSmall,
          ),
          child: Center(
            child: Text(
              entry.key,
              style: DSTypographyFoundations.labelSmall.copyWith(
                color: Colors.lightGreenAccent,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }).toList(),
    );
  }

  // ===== 2. RADIOS =====
  Widget _buildRadiusTokens() {
    final radii = {
      "radiusXS": DSRadius.radiusXS,
      "radiusSM": DSRadius.radiusSM,
      "radiusMD": DSRadius.radiusMD,
      "radiusLG": DSRadius.radiusLG,
      "radiusXL": DSRadius.radiusXL,
    };

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: radii.entries.map((entry) {
        return Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: DSColors.brandSecondary.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(entry.value),
          ),
          child: Center(
            child: Text(
              entry.key,
              style: DSTypographyFoundations.labelSmall,
              textAlign: TextAlign.center,
            ),
          ),
        );
      }).toList(),
    );
  }

  // ===== 3. SHADOWS =====
  Widget _buildShadowTokens() {
    final shadows = {
      "shadowSmall": DSShadows.shadowSmall,
      "shadowMedium": DSShadows.shadowMedium,
      "shadowLarge": DSShadows.shadowLarge,
    };

    return Wrap(
      spacing: 16,
      children: shadows.entries.map((e) {
        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: DSColors.bgPrimary,
            boxShadow: e.value,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              e.key,
              style: DSTypographyFoundations.labelSmall.copyWith(
                color: DSColors.bgPrimaryDark,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }).toList(),
    );
  }

  // ===== 4. SIZES =====
  Widget _buildSizeTokens() {
    final sizes = {
      "iconSizeSmall": DSSizes.iconSizeSmall,
      "iconSizeMedium": DSSizes.iconSizeMedium,
      "iconSizeLarge": DSSizes.iconSizeLarge,
      "buttonHeightSmall": DSSizes.buttonHeightSmall,
      "buttonHeightMedium": DSSizes.buttonHeightMedium,
      "buttonHeightLarge": DSSizes.buttonHeightLarge,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: sizes.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Container(
                width: entry.value.toDouble(),
                height: 10,
                color: DSColors.brandPrimary.withValues(alpha: 0.5),
              ),
              const SizedBox(width: 8),
              Text(
                "${entry.key} (${entry.value})",
                style: DSTypographyFoundations.labelSmall,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // ===== 5. SPACING =====
  Widget _buildSpacingTokens() {
    final spacings = {
      "separatorXS": DSSpacing.spaceXS,
      "separatorSmall": DSSpacing.spaceSM,
      "separatorMedium": DSSpacing.spaceMD,
      "separatorLarge": DSSpacing.spaceLG,
      "separatorXL": DSSpacing.spaceXL,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: spacings.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Container(
                width: entry.value.toDouble(),
                height: 10,
                color: DSColors.brandSecondary.withValues(alpha: 0.5),
              ),
              const SizedBox(width: 8),
              Text(
                "${entry.key} (${entry.value})",
                style: DSTypographyFoundations.labelSmall,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // ===== 6. TYPOGRAPHY =====
  Widget _buildTypographyTokens() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("displayLarge", style: DSTypography.displayLargeW500),
        Text("bodyMedium", style: DSTypography.displayMediumBold),
        Text("labelSmall", style: DSTypography.displaySmallW500),
      ],
    );
  }
}
