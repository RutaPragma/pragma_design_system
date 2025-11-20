import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/foundations/foundations.dart';

/// Campo de texto base del sistema de diseño.
///
/// Este átomo estandariza el aspecto de los inputs en toda la aplicación.
/// Puede ser utilizado para campos de texto, búsqueda, correo, contraseña, etc.
///
/// Ejemplo de uso:
/// ```dart
/// DSInputField(
///   label: 'Correo electrónico',
///   hintText: 'Ingresa tu correo',
///   controller: TextEditingController(),
///   keyboardType: TextInputType.emailAddress,
///   onChanged: (value) => print(value),
/// )
/// ```
class DSInputField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final int? maxLines;
  final int? minLines;

  const DSInputField({
    super.key,
    this.label,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.maxLines = 1,
    this.minLines,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final field = TextFormField(
      key: ValueKey("dsInputFieldText_${label ?? hintText ?? 'field'}"),
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      enabled: enabled,
      validator: validator,
      onChanged: onChanged,
      maxLines: maxLines,
      minLines: minLines,
      style: DSTypographyFoundations.bodyMedium.copyWith(
        color: enabled
            ? DSColorsFoundations.textPrimary
            : DSColorsFoundations.textHint,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: DSTypographyFoundations.hint.copyWith(
          color: DSColorsFoundations.textHint,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: DSColorsFoundations.inputFill,
        isDense: true,
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
          borderSide: BorderSide(
            color: isDark
                ? DSColorsFoundations.inputFocusDark
                : DSColorsFoundations.inputFocus,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DSRadiusFoundations.radiusSM),
          borderSide: BorderSide(color: DSColorsFoundations.buttonDisabled),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DSRadiusFoundations.radiusSM),
          borderSide: BorderSide(color: DSColorsFoundations.error),
        ),
      ),
    );

    if (label == null) return field;

    return Column(
      key: ValueKey("dsInputFieldColumn_${label ?? 'field'}"),
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          key: ValueKey("dsInputFieldLabelPadding_${label ?? 'field'}"),
          padding: EdgeInsets.only(bottom: DSSizesFoundations.separatorSmall),
          child: Text(
            key: ValueKey("dsInputFieldLabelText_${label ?? 'field'}"),
            label!,
            style: DSTypographyFoundations.labelMedium.copyWith(
              color: enabled
                  ? DSColorsFoundations.textSecondary
                  : DSColorsFoundations.textHint,
            ),
          ),
        ),
        field,
      ],
    );
  }
}
