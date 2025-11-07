import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/foundations/foundations.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,

  // scaffoldBackgroundColor define el fondo principal de las pantallas.
  scaffoldBackgroundColor:
      DSColorsFoundations.backgroundPrimary, // <-- fondo general
  // ColorScheme: la fuente de verdad para colores semánticos.
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: DSColorsFoundations.brandPrimary,
    onPrimary: DSColorsFoundations.textOnPrimary,
    secondary: DSColorsFoundations.brandSecondary,
    onSecondary: DSColorsFoundations.textOnSecondary,
    surface: DSColorsFoundations.surfaceLight, // surface semantic
    onSurface: DSColorsFoundations.textPrimary,
    error: DSColorsFoundations.error,
    onError: DSColorsFoundations.textOnPrimary, // o un color apropiado
  ),

  // Elevated buttons
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: DSColorsFoundations.brandPrimary,
      foregroundColor: DSColorsFoundations.textOnPrimary,
      minimumSize: Size(double.infinity, DSSizesFoundations.buttonHeightMedium),
      padding: EdgeInsets.symmetric(
        horizontal: DSSizesFoundations.separatorMedium / 2,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DSRadiusFoundations.radiusSM),
      ),
      textStyle: DSTypographyFoundations.buttonPrimary,
    ),
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: DSColorsFoundations.textOnPrimary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(DSRadiusFoundations.radiusSM),
    ),
  ),

  // Text field / inputs
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: DSColorsFoundations.inputFill,
    contentPadding: EdgeInsets.symmetric(
      vertical: DSSizesFoundations.separatorSmall,
      horizontal: DSSizesFoundations.separatorMedium,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(DSRadiusFoundations.radiusSM),
      borderSide: BorderSide(color: DSColorsFoundations.inputBorder),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(DSRadiusFoundations.radiusSM),
      borderSide: BorderSide(color: DSColorsFoundations.inputFocus),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(DSRadiusFoundations.radiusSM),
      borderSide: BorderSide(color: DSColorsFoundations.error),
    ),
    hintStyle: DSTypographyFoundations.hint.copyWith(
      color: DSColorsFoundations.textHint,
    ),
  ),

  // Icon theme
  iconTheme: IconThemeData(
    color: DSColorsFoundations.textPrimary,
    size: DSSizesFoundations.iconSizeMedium,
  ),

  // AppBar theme: usa colorScheme.primary y onPrimary para texto/íconos.
  appBarTheme: AppBarTheme(
    backgroundColor: DSColorsFoundations.brandPrimary,
    foregroundColor: DSColorsFoundations.textOnPrimary,
    elevation: 2.0,
    centerTitle: false,
    iconTheme: IconThemeData(
      color: DSColorsFoundations.textOnPrimary,
      size: DSSizesFoundations.iconSizeMedium,
    ),
  ),
  // Otros ajustes menores
  useMaterial3: true,
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,

  // Fondo principal de las pantallas
  scaffoldBackgroundColor: DSColorsFoundations.backgroundPrimaryDark,

  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: DSColorsFoundations.brandPrimaryDark,
    onPrimary: DSColorsFoundations.textOnPrimaryDark,
    secondary: DSColorsFoundations.brandSecondaryDark,
    onSecondary: DSColorsFoundations.textOnSecondaryDark,
    surface: DSColorsFoundations.surfaceDark, // Color base de superficies
    onSurface: DSColorsFoundations.textPrimaryDark,
    error: DSColorsFoundations.errorDark,
    onError: DSColorsFoundations.textPrimary,
    surfaceContainerHighest:
        DSColorsFoundations.surfaceDark, // Evita overlays oscuros
    surfaceTint: Colors.red,
  ),

  //Añade esta línea al ThemeData base para desactivar el tinte en general
  // surfaceTintColor: Colors.transparent,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: DSColorsFoundations.brandPrimaryDark,
      foregroundColor: DSColorsFoundations.textOnPrimaryDark,
      minimumSize: Size(double.infinity, DSSizesFoundations.buttonHeightMedium),
      padding: EdgeInsets.symmetric(
        horizontal: DSSizesFoundations.separatorMedium / 2,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DSRadiusFoundations.radiusSM),
      ),
      textStyle: DSTypographyFoundations.buttonPrimary,
      elevation: 2,
      shadowColor: DSColorsFoundations.backgroundOnPrimaryDark,
    ),
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: DSColorsFoundations.textOnPrimaryDark,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(DSRadiusFoundations.radiusSM),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: DSColorsFoundations.inputFillDark,
    contentPadding: EdgeInsets.symmetric(
      vertical: DSSizesFoundations.separatorSmall,
      horizontal: DSSizesFoundations.separatorMedium,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(DSRadiusFoundations.radiusSM),
      borderSide: BorderSide(color: DSColorsFoundations.inputBorderDark),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(DSRadiusFoundations.radiusSM),
      borderSide: BorderSide(color: DSColorsFoundations.inputFocusDark),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(DSRadiusFoundations.radiusSM),
      borderSide: BorderSide(color: DSColorsFoundations.errorDark),
    ),
    hintStyle: DSTypographyFoundations.hint.copyWith(
      color: DSColorsFoundations.textHintDark,
    ),
  ),

  iconTheme: IconThemeData(
    color: DSColorsFoundations.textPrimaryDark,
    size: DSSizesFoundations.iconSizeMedium,
  ),

  appBarTheme: AppBarTheme(
    // backgroundColor: Colors.white,
    // foregroundColor: Colors.black,
    elevation: 2.0,
    centerTitle: false,
    // iconTheme: IconThemeData(
    //   color: Colors.black,
    //   size: DSSizesFoundations.iconSizeMedium,
    // ),
  ),
);
