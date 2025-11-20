import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/components/atoms/atoms.dart';
import 'package:pragma_design_system/src/foundations/foundations.dart';

/// Formulario de registro de usuario altamente parametrizable.
///
/// Ejemplo de uso:
/// ```dart
/// DSRegisterUserForm(
///   config: {
///     "title": "Crear cuenta",
///     "subtitle": "Regístrate para comenzar",
///     "nameLabel": "Nombre completo",
///     "nameHint": "Ingresa tu nombre",
///     "emailLabel": "Correo electrónico",
///     "emailHint": "ejemplo@correo.com",
///     "passwordLabel": "Contraseña",
///     "passwordHint": "••••••••",
///     "confirmPasswordLabel": "Confirmar contraseña",
///     "confirmPasswordHint": "Vuelve a escribir la contraseña",
///     "buttonLabel": "Registrarme",
///     "minPasswordLength": 8,
///     "nameRequired": "El nombre es obligatorio",
///     "emailRequired": "El correo es obligatorio",
///     "emailInvalid": "Correo inválido",
///     "passwordRequired": "La contraseña es obligatoria",
///     "passwordTooShort": "Debe tener al menos 8 caracteres",
///     "confirmPasswordRequired": "Confirma tu contraseña",
///     "passwordsNotMatch": "Las contraseñas no coinciden",
///   },
///   onSubmit: (data) => print(data),
/// )
/// ```
class DSRegisterUserForm extends StatefulWidget {
  final Map<String, dynamic> config;
  final void Function(Map<String, String> data)? onSubmit;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final bool showPasswordToggle;

  const DSRegisterUserForm({
    super.key,
    required this.config,
    this.onSubmit,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.showPasswordToggle = true,
  });

  @override
  State<DSRegisterUserForm> createState() => _DSRegisterUserFormState();
}

class _DSRegisterUserFormState extends State<DSRegisterUserForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

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
      key: const ValueKey("dsRegisterFormContainer"),
      padding: EdgeInsets.all(DSSizesFoundations.separatorLarge),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(DSRadiusFoundations.radiusLG),
        boxShadow: DSShadowsFoundations.shadowMedium,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          key: const ValueKey("dsRegisterFormColumn"),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              key: const ValueKey("dsRegisterFormTitle"),
              _get("title", "Crear cuenta"),
              style: DSTypographyFoundations.displaySmall.copyWith(
                color: textColor,
              ),
            ),
            if (_get("subtitle").isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                key: const ValueKey("dsRegisterFormSubtitle"),
                _get("subtitle"),
                style: DSTypographyFoundations.bodySmall.copyWith(
                  color: textColor.withValues(alpha: 0.7),
                ),
              ),
            ],
            SizedBox(height: DSSizesFoundations.separatorLarge),

            DSInputField(
              key: const ValueKey("dsRegisterFormNameField"),
              label: _get("nameLabel", "Nombre completo"),
              hintText: _get("nameHint", "Ingresa tu nombre"),
              controller: _nameCtrl,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return _get("nameRequired", "El nombre es obligatorio");
                }
                return null;
              },
            ),
            SizedBox(height: DSSizesFoundations.separatorMedium),

            DSInputField(
              key: const ValueKey("dsRegisterFormEmailField"),
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
                  return _get("emailInvalid", "Correo inválido");
                }
                return null;
              },
            ),
            SizedBox(height: DSSizesFoundations.separatorMedium),

            DSInputField(
              key: const ValueKey("dsRegisterFormPasswordField"),
              label: _get("passwordLabel", "Contraseña"),
              hintText: _get("passwordHint", "••••••••"),
              controller: _passwordCtrl,
              obscureText: _obscurePassword,
              suffixIcon: widget.showPasswordToggle
                  ? IconButton(
                      key: const ValueKey("dsRegisterFormPasswordToggle"),
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: DSColorsFoundations.textHint,
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
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
            SizedBox(height: DSSizesFoundations.separatorMedium),

            DSInputField(
              key: const ValueKey("dsRegisterFormConfirmPasswordField"),
              label: _get("confirmPasswordLabel", "Confirmar contraseña"),
              hintText: _get(
                "confirmPasswordHint",
                "Vuelve a escribir la contraseña",
              ),
              controller: _confirmPasswordCtrl,
              obscureText: _obscureConfirmPassword,
              suffixIcon: widget.showPasswordToggle
                  ? IconButton(
                      key: const ValueKey("dsRegisterFormConfirmPasswordToggle"),
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: DSColorsFoundations.textHint,
                      ),
                      onPressed: () => setState(
                        () =>
                            _obscureConfirmPassword = !_obscureConfirmPassword,
                      ),
                    )
                  : null,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return _get(
                    "confirmPasswordRequired",
                    "Confirma tu contraseña",
                  );
                }
                if (value != _passwordCtrl.text) {
                  return _get(
                    "passwordsNotMatch",
                    "Las contraseñas no coinciden",
                  );
                }
                return null;
              },
            ),

            SizedBox(height: DSSizesFoundations.separatorLarge),

            if (widget.isLoading)
              DSLoader(
                key: const ValueKey("dsRegisterFormLoader"),
                label: _get("loadingText", "Registrando..."),
              )
            else
              DSButton(
                key: const ValueKey("dsRegisterFormSubmitButton"),
                label: _get("buttonLabel", "Crear cuenta"),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    widget.onSubmit?.call({
                      "name": _nameCtrl.text.trim(),
                      "email": _emailCtrl.text.trim(),
                      "password": _passwordCtrl.text.trim(),
                    });
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}
