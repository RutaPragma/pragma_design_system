import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// Muestra visualmente cómo funcionan los Foundations.
class DSFoundationsShowcase extends StatelessWidget {
  const DSFoundationsShowcase({super.key});

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
        title: const Text("Foundations"),
        backgroundColor: isDark
            ? DSColorsFoundations.surfaceDark
            : DSColorsFoundations.brandPrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle("1. DSColorsFoundations", textColor),
          _buildDescription(
            "Define la paleta de colores base del sistema (marca, textos, fondos, estados y botones).",
          ),
          _buildColorPreview(),

          _buildSectionTitle("2. DSTypographyFoundations", textColor),
          _buildDescription(
            "Gestiona tipografías, pesos y tamaños para textos jerárquicos.",
          ),
          _buildTypographyPreview(),

          _buildSectionTitle("3. DSRadiusFoundations", textColor),
          _buildDescription(
            "Establece los radios de borde estándar para mantener coherencia visual.",
          ),
          _buildRadiusPreview(),

          _buildSectionTitle("4. DSShadowsFoundations", textColor),
          _buildDescription(
            "Define las sombras para tarjetas, botones y elevaciones.",
          ),
          _buildShadowPreview(),

          _buildSectionTitle("5. DSSizes & DSSpacingFoundations", textColor),
          _buildDescription(
            "Estandariza tamaños de íconos, botones y separaciones.",
          ),
          _buildSpacingPreview(),

          _buildSectionTitle("6. Temas: lightTheme & darkTheme", textColor),
          _buildDescription(
            "Implementa las combinaciones cromáticas y tipográficas en ambos modos.",
          ),
          _buildThemePreview(context),
        ],
      ),
    );
  }

  // ====== SECCIONES ======

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

  // ====== DEMOS ======

  Widget _buildColorPreview() {
    final colors = {
      "Primario": DSColorsFoundations.brandPrimary,
      "Secundario": DSColorsFoundations.brandSecondary,
      "Éxito": DSColorsFoundations.success,
      "Error": DSColorsFoundations.error,
      "Fondo Dark": DSColorsFoundations.backgroundPrimaryDark,
    };

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: colors.entries.map((entry) {
        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: entry.value,
            borderRadius: BorderRadius.circular(12),
            boxShadow: DSShadowsFoundations.shadowSmall,
          ),
          child: Center(
            child: Text(
              entry.key,
              style: DSTypographyFoundations.labelSmall.copyWith(
                color: DSColorsFoundations.textOnPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTypographyPreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Display Large", style: DSTypographyFoundations.displayLarge),
        Text("Body Medium", style: DSTypographyFoundations.bodyMedium),
        Text("Label Small", style: DSTypographyFoundations.labelSmall),
      ],
    );
  }

  Widget _buildRadiusPreview() {
    final radii = {
      "SM": DSRadiusFoundations.radiusSM,
      "MD": DSRadiusFoundations.radiusMD,
      "LG": DSRadiusFoundations.radiusLG,
      "XL": DSRadiusFoundations.radiusXL,
    };

    return Wrap(
      spacing: 12,
      children: radii.entries.map((e) {
        return Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: DSColorsFoundations.brandPrimary.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(e.value),
          ),
          child: Center(child: Text(e.key)),
        );
      }).toList(),
    );
  }

  Widget _buildShadowPreview() {
    return Wrap(
      spacing: 16,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: DSColorsFoundations.brandSecondary,
            boxShadow: DSShadowsFoundations.shadowSmall,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(child: Text("Small")),
        ),
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: DSColorsFoundations.brandSecondary,
            boxShadow: DSShadowsFoundations.shadowMedium,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(child: Text("Medium")),
        ),
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: DSColorsFoundations.brandSecondary,
            boxShadow: DSShadowsFoundations.shadowLarge,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(child: Text("Large")),
        ),
      ],
    );
  }

  Widget _buildSpacingPreview() {
    final spacings = [
      DSSizesFoundations.separatorSmall,
      DSSizesFoundations.separatorMedium,
      DSSizesFoundations.separatorLarge,
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: spacings.map((s) {
        return Container(
          width: s * 2,
          height: 16,
          color: DSColorsFoundations.brandPrimary.withValues(alpha: 0.4),
          child: Center(
            child: Text(
              "${s.toInt()}",
              style: DSTypographyFoundations.labelSmall,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildThemePreview(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildThemeBox(
          "Light Theme",
          Colors.white,
          DSColorsFoundations.brandPrimary,
        ),
        _buildThemeBox(
          "Dark Theme",
          const Color(0xFF1A1A1A),
          DSColorsFoundations.brandPrimaryDark,
        ),
      ],
    );
  }

  Widget _buildThemeBox(String title, Color bg, Color accent) {
    return Container(
      width: 120,
      height: 100,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        boxShadow: DSShadowsFoundations.shadowSmall,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.brightness_6_rounded, color: accent),
          const SizedBox(height: 8),
          Text(title, style: DSTypographyFoundations.labelSmall),
        ],
      ),
    );
  }
}
