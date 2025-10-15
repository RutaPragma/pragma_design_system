import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/tokens/ds_colors.dart';

///
/// Capa fundacional de colores del sistema de diseño.
/// Esta clase **no define nuevos valores hexadecimales**, sino que toma los
/// colores base de [DSColors] y los organiza por propósito semántico.
///
/// Esto permite que los componentes utilicen nombres funcionales y que el tema
/// pueda cambiar sin alterar los tokens base.
///
class DSColorsFoundations {
  DSColorsFoundations._();

  // ===== BRAND =====
  static const Color brandPrimary = DSColors.brandPrimary;
  static const Color brandSecondary = DSColors.brandSecondary;

  static const Color brandPrimaryDark = DSColors.brandPrimaryDark;
  static const Color brandSecondaryDark = DSColors.brandSecondaryDark;

  // ===== BACKGROUNDS =====
  static const Color backgroundPrimary = DSColors.bgPrimary;
  static const Color backgroundSecondary = DSColors.bgSecondary;
  static const Color backgroundDark = DSColors.bgDark;

  static const Color backgroundPrimaryDark = DSColors.bgPrimaryDark;
  static const Color backgroundOnPrimaryDark = DSColors.bgOnPrimaryDark;
  static const Color backgroundSecondaryDark = DSColors.bgSecondaryDark;
  static const Color backgroundOnSecondaryDark = DSColors.bgOnSecondaryDark;
  static const Color backgroundLightDark = DSColors.bgLightDark;

  // ===== SURFACE =====
  static const Color surfaceLight = DSColors.surfaceLight;
  static const Color surfaceDark = DSColors.surfaceDark;

  static const Color surfacePrimaryDark = DSColors.surfacePrimaryDark;
  static const Color surfaceSecondaryDark = DSColors.surfaceSecondaryDark;

  // ===== TEXTOS =====
  static const Color textPrimary = DSColors.textPrimary;
  static const Color textSecondary = DSColors.textSecondary;
  static const Color textHint = DSColors.textHint;
  static const Color textOnPrimary = DSColors.textOnPrimary;
  static const Color textOnSecondary = DSColors.textOnSecondary;

  static const Color textPrimaryDark = DSColors.textPrimaryDark;
  static const Color textSecondaryDark = DSColors.textSecondaryDark;
  static const Color textHintDark = DSColors.textHintDark;
  static const Color textOnPrimaryDark = DSColors.textOnPrimaryDark;
  static const Color textOnSecondaryDark = DSColors.textOnSecondaryDark;

  // ===== ESTADOS =====
  static const Color success = DSColors.success;
  static const Color error = DSColors.error;
  static const Color warning = DSColors.warning;
  static const Color info = DSColors.info;

  static const Color successDark = DSColors.successDark;
  static const Color errorDark = DSColors.errorDark;
  static const Color warningDark = DSColors.warningDark;
  static const Color infoDark = DSColors.infoDark;

  // ===== BOTONES =====
  static const Color buttonPrimary = DSColors.colorButtonPrimary;
  static const Color buttonOnPrimary = DSColors.colorButtonOnPrimary;
  static const Color buttonSecondary = DSColors.colorButtonSecondary;
  static const Color buttonOnSecondary = DSColors.colorButtonOnSecondary;
  static const Color buttonDisabled = DSColors.colorButtonDisabled;
  static const Color buttonOnDisabled = DSColors.colorButtonOnDisabled;

  static const Color buttonPrimaryDark = DSColors.colorButtonPrimaryDark;
  static const Color buttonOnPrimaryDark = DSColors.colorButtonOnPrimaryDark;
  static const Color buttonSecondaryDark = DSColors.colorButtonSecondaryDark;
  static const Color buttonOnSecondaryDark =
      DSColors.colorButtonOnSecondaryDark;
  static const Color buttonDisabledDark = DSColors.colorButtonDisabledDark;
  static const Color buttonOnDisabledDark = DSColors.colorButtonOnDisabledDark;

  // ===== INPUTS =====
  static const Color inputBorder = DSColors.inputBorder;
  static const Color inputFill = DSColors.inputFill;
  static const Color inputFocus = DSColors.inputFocus;

  static const Color inputBorderDark = DSColors.inputBorderDark;
  static const Color inputFillDark = DSColors.inputFillDark;
  static const Color inputFocusDark = DSColors.inputFocusDark;

  // ===== DIVIDERS / SOMBRAS =====
  static const Color divider = DSColors.divider;
  static const Color dividerDark = DSColors.dividerDark;

  static const Color shadow = DSColors.shadow;
  static const Color shadowDark = DSColors.shadowDark;
}
