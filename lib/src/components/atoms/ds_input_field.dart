import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/foundations/foundations.dart';

/// Campo de texto base del sistema de diseño.
/// 
/// Este átomo estandariza el aspecto de los inputs en toda la aplicación.
/// Puede ser utilizado para campos de texto, búsqueda, correo, contraseña, etc.
/// 
/// - Aplica colores desde [DSColorsFoundations]
/// - Tamaños desde [DSSizesFoundations]
/// - Tipografía desde [DSTypographyFoundations]
/// - Bordes desde [DSRadiusFoundations]
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: EdgeInsets.only(
              bottom: DSSizesFoundations.separatorSmall,
            ),
            child: Text(
              label!,
              style: DSTypographyFoundations.labelMedium.copyWith(
                color: enabled
                    ? DSColorsFoundations.textSecondary
                    : DSColorsFoundations.textHint,
              ),
            ),
          ),
        TextFormField(
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
            contentPadding: EdgeInsets.symmetric(
              vertical: DSSizesFoundations.separatorSmall,
              horizontal: DSSizesFoundations.separatorMedium,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(DSRadiusFoundations.radiusSM),
              borderSide: BorderSide(color: DSColorsFoundations.inputBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(DSRadiusFoundations.radiusSM),
              borderSide: BorderSide(color: DSColorsFoundations.inputFocus),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(DSRadiusFoundations.radiusSM),
              borderSide:
                  BorderSide(color: DSColorsFoundations.buttonDisabled),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(DSRadiusFoundations.radiusSM),
              borderSide: BorderSide(color: DSColorsFoundations.error),
            ),
          ),
        ),
      ],
    );
  }
}