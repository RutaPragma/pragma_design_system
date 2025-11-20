import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/components/atoms/atoms.dart';
import 'package:pragma_design_system/src/foundations/foundations.dart';

/// Formulario de autenticación parametrizable mediante un mapa de configuración.
///
/// Ejemplo de uso:
/// ```dart
/// DSAuthForm(
///   config: {
///     "title": "Iniciar sesión",
///     "subtitle": "Bienvenido de nuevo",
///     "emailLabel": "Correo electrónico",
///     "emailHint": "ejemplo@correo.com",
///     "passwordLabel": "Contraseña",
///     "passwordHint": "••••••••",
///     "forgotPasswordText": "¿Olvidaste tu contraseña?",
///     "buttonLabel": "Entrar",
///     "minPasswordLength": 6,
///     "emailRequired": "El correo es obligatorio",
///     "emailInvalid": "Ingresa un correo válido",
///     "passwordRequired": "La contraseña es obligatoria",
///     "passwordTooShort": "Debe tener al menos 6 caracteres",
///   },
///   onSubmit: (email, password) => print("$email / $password"),
/// )
/// ```
class DSAuthForm extends StatefulWidget {
  final Map<String, dynamic> config;
  final void Function(String email, String password)? onSubmit;
  final VoidCallback? onForgotPassword;
  final bool isLoading;
  final bool showForgotPassword;
  final Color? backgroundColor;
  final Color? textColor;
  final bool showPasswordToggle;

  const DSAuthForm({
    super.key,
    required this.config,
    this.onSubmit,
    this.onForgotPassword,
    this.isLoading = false,
    this.showForgotPassword = true,
    this.backgroundColor,
    this.textColor,
    this.showPasswordToggle = true,
  });

  @override
  State<DSAuthForm> createState() => _DSAuthFormState();
}

class _DSAuthFormState extends State<DSAuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscurePassword = true;

  String _get(String key, [String fallback = ""]) =>
      widget.config[key]?.toString() ?? fallback;

  int _getInt(String key, [int fallback = 6]) =>
      (widget.config[key] is int) ? widget.config[key] : fallback;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor =
        widget.backgroundColor ??
        (isDark
            ? DSColorsFoundations.surfaceDark
            : DSColorsFoundations.surfaceLight);

    final textColor =
        widget.textColor ??
        (isDark
            ? DSColorsFoundations.textPrimaryDark
            : DSColorsFoundations.textPrimary);

    final minPassLength = _getInt("minPasswordLength", 6);

    return Container(
      key: const ValueKey("dsAuthFormContainer"),
      padding: EdgeInsets.all(DSSizesFoundations.separatorLarge),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(DSRadiusFoundations.radiusLG),
        boxShadow: DSShadowsFoundations.shadowMedium,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          key: const ValueKey("dsAuthFormColumn"),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              key: const ValueKey("dsAuthFormTitle"),
              _get("title", "Iniciar sesión"),
              style: DSTypographyFoundations.displaySmall.copyWith(
                color: textColor,
              ),
            ),
            if (_get("subtitle").isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                key: const ValueKey("dsAuthFormSubtitle"),
                _get("subtitle"),
                style: DSTypographyFoundations.bodySmall.copyWith(
                  color: textColor..withValues(alpha: 0.7),
                ),
              ),
            ],
            SizedBox(height: DSSizesFoundations.separatorLarge),

            DSInputField(
              key: const ValueKey("dsAuthFormEmailField"),
              label: _get("emailLabel", "Correo electrónico"),
              hintText: _get("emailHint", "tu@correo.com"),
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return _get("emailRequired", "El correo es obligatorio");
                }
                final emailReg = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                if (!emailReg.hasMatch(value)) {
                  return _get("emailInvalid", "Ingresa un correo válido");
                }
                return null;
              },
            ),

            SizedBox(height: DSSizesFoundations.separatorMedium),

            DSInputField(
              key: const ValueKey("dsAuthFormPasswordField"),
              label: _get("passwordLabel", "Contraseña"),
              hintText: _get("passwordHint", "••••••••"),
              controller: _passwordCtrl,
              obscureText: _obscurePassword,
              suffixIcon: widget.showPasswordToggle
                  ? IconButton(
                      key: const ValueKey("dsAuthFormPasswordToggle"),
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: DSColorsFoundations.textHint,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    )
                  : null,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return _get(
                    "passwordRequired",
                    "La contraseña es obligatoria",
                  );
                }
                if (value.length < minPassLength) {
                  return _get(
                    "passwordTooShort",
                    "Debe tener al menos $minPassLength caracteres",
                  );
                }
                return null;
              },
            ),

            if (widget.showForgotPassword)
              Align(
                key: const ValueKey("dsAuthFormForgotPasswordAlign"),
                alignment: Alignment.centerRight,
                child: TextButton(
                  key: const ValueKey("dsAuthFormForgotPasswordButton"),
                  onPressed: widget.onForgotPassword,
                  child: Text(
                    _get("forgotPasswordText", "¿Olvidaste tu contraseña?"),
                    style: DSTypographyFoundations.bodySmall.copyWith(
                      color: isDark
                          ? DSColorsFoundations.brandPrimaryDark
                          : DSColorsFoundations.brandPrimary,
                    ),
                  ),
                ),
              ),

            SizedBox(height: DSSizesFoundations.separatorLarge),

            if (widget.isLoading)
              DSLoader(
                key: const ValueKey("dsAuthFormLoader"),
                label: _get("loadingText", "Verificando..."),
              )
            else
              DSButton(
                key: const ValueKey("dsAuthFormSubmitButton"),
                label: _get("buttonLabel", "Entrar"),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    widget.onSubmit?.call(
                      _emailCtrl.text.trim(),
                      _passwordCtrl.text.trim(),
                    );
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}
