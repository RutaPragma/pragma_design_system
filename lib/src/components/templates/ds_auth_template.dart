import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/components/atoms/atoms.dart';
import 'package:pragma_design_system/src/components/organisms/organisms.dart';
import 'package:pragma_design_system/src/foundations/foundations.dart';

/// Template de Autenticación (Login / Registro)
///
/// Combina los organismos:
/// - DSAuthForm (para iniciar sesión)
/// - DSRegisterUserForm (para crear una cuenta)
///
/// Se puede configurar completamente desde un Map.
/// También soporta imagen ilustrativa, logo y textos personalizados.
///
/// Ejemplo de uso:
/// ```dart
/// DSAuthTemplate(
///   config: {
///     "loginConfig": {
///       "title": "Bienvenido de nuevo",
///       "subtitle": "Ingresa tus credenciales",
///       "emailLabel": "Correo",
///       "emailHint": "usuario@correo.com",
///       "passwordLabel": "Clave",
///       "passwordHint": "Tu contraseña segura",
///       "forgotPasswordText": "Recuperar acceso",
///       "buttonLabel": "Iniciar sesión",
///       "minPasswordLength": 8,
///       "emailRequired": "El correo no puede estar vacío",
///       "emailInvalid": "Formato de correo incorrecto",
///       "passwordRequired": "Debes ingresar tu contraseña",
///       "passwordTooShort": "La contraseña es demasiado corta",
///     },
///     "registerConfig": {
///       "title": "Crea tu cuenta",
///       "subtitle": "Regístrate para continuar",
///       "nameLabel": "Nombre y apellido",
///       "nameHint": "Ejemplo: Jhony Rentería",
///       "emailLabel": "Correo",
///       "emailHint": "usuario@correo.com",
///       "passwordLabel": "Contraseña",
///       "passwordHint": "Mínimo 8 caracteres",
///       "confirmPasswordLabel": "Repetir contraseña",
///       "confirmPasswordHint": "Confirma tu contraseña",
///       "buttonLabel": "Registrarme ahora",
///       "minPasswordLength": 8,
///       "nameRequired": "El nombre es obligatorio",
///       "emailRequired": "El correo es obligatorio",
///       "emailInvalid": "Formato de correo inválido",
///       "passwordRequired": "La contraseña es obligatoria",
///       "passwordTooShort": "Debe tener al menos 8 caracteres",
///       "confirmPasswordRequired": "Confirma la contraseña",
///       "passwordsNotMatch": "Las contraseñas no coinciden",
///     },
///     "onLogin": (email, password) {
///       log("Email: $email / Password: $password");
///     },
///     "onRegister": (data) {
///       log("Usuario: "+data['name']+", Email: "+data['email']);
///     },
///   },
/// )
/// ```
class DSAuthTemplate extends StatefulWidget {
  const DSAuthTemplate({
    super.key,
    required this.config,
    required this.onLogin,
    required this.onRegister,
    this.socialButtons,
  });
  final Map<String, dynamic> config;
  final void Function(String, String) onLogin;
  final void Function(Map<String, dynamic>) onRegister;
  final List<DSButton>? socialButtons;

  @override
  State<DSAuthTemplate> createState() => _DSAuthTemplateState();
}

class _DSAuthTemplateState extends State<DSAuthTemplate> {
  bool _isLogin = true;
  bool isDark = false;
  late List<DSButton> listSocialButtons;

  @override
  void initState() {
    listSocialButtons = widget.socialButtons ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    isDark = theme.brightness == Brightness.dark;
    final bgColor =
        widget.config["backgroundColor"] ??
        (isDark
            ? DSColorsFoundations.surfaceDark
            : DSColorsFoundations.surfaceLight);

    final accentColor =
        widget.config["accentColor"] ??
        (isDark
            ? DSColorsFoundations.brandPrimaryDark
            : DSColorsFoundations.brandPrimary);

    final textColor =
        widget.config["textColor"] ??
        (isDark
            ? DSColorsFoundations.textPrimaryDark
            : DSColorsFoundations.textPrimary);

    final logoUrl = widget.config["logoPath"];

    final loginConfig = widget.config["loginConfig"] ?? {};
    final registerConfig = widget.config["registerConfig"] ?? {};

    return Scaffold(
      key: const ValueKey("dsAuthTemplateScaffold"),
      backgroundColor: bgColor,
      body: SafeArea(
        key: const ValueKey("dsAuthTemplateSafeArea"),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              key: const ValueKey("dsAuthTemplateRow"),
              children: [
                Expanded(
                  key: const ValueKey("dsAuthTemplateFormExpanded"),
                  flex: 1,
                  child: Center(
                    key: const ValueKey("dsAuthTemplateCenter"),
                    child: SingleChildScrollView(
                      key: const ValueKey("dsAuthTemplateScroll"),
                      padding: const EdgeInsets.all(
                        DSSizesFoundations.separatorLarge,
                      ),
                      child: Column(
                        key: const ValueKey("dsAuthTemplateColumn"),
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Logo opcional
                          if (logoUrl != null)
                            Padding(
                              key: const ValueKey("dsAuthTemplateLogoPadding"),
                              padding: const EdgeInsets.only(
                                bottom: 32,
                                top: 16,
                              ),
                              child: Image.asset(
                                logoUrl,
                                key: const ValueKey("dsAuthTemplateLogo"),
                                height: 80,
                              ),
                            ),

                          Text(
                            key: const ValueKey("dsAuthTemplateTitle"),
                            _isLogin
                                ? (widget.config["loginTitle"] ??
                                      "Iniciar Sesión")
                                : (widget.config["registerTitle"] ??
                                      "Crear Cuenta"),
                            style: DSTypographyFoundations.displayMedium
                                .copyWith(color: textColor),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),

                          AnimatedSwitcher(
                            key: const ValueKey("dsAuthTemplateSwitcher"),
                            duration: const Duration(milliseconds: 350),
                            transitionBuilder: (child, animation) =>
                                FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                            child: _isLogin
                                ? DSAuthForm(
                                    key: const ValueKey("login"),
                                    config: loginConfig,
                                    onSubmit: (email, password) =>
                                        widget.onLogin.call(email, password),
                                  )
                                : DSRegisterUserForm(
                                    key: const ValueKey("register"),
                                    config: registerConfig,
                                    onSubmit: (data) =>
                                        widget.onRegister.call(data),
                                  ),
                          ),
                          const SizedBox(height: 24),

                          Row(
                            key: const ValueKey("dsAuthTemplateToggleRow"),
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                key:
                                    const ValueKey("dsAuthTemplateToggleText"),
                                _isLogin
                                    ? "¿No tienes cuenta?"
                                    : "¿Ya tienes cuenta?",
                                style: DSTypographyFoundations.bodySmall
                                    .copyWith(color: textColor),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  setState(() => _isLogin = !_isLogin);
                                },
                                child: Text(
                                  key: const ValueKey(
                                    "dsAuthTemplateToggleAction",
                                  ),
                                  _isLogin ? "Regístrate" : "Inicia sesión",
                                  style: DSTypographyFoundations.bodySmall
                                      .copyWith(
                                        color: accentColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Divider decorativo
                          if (listSocialButtons.isNotEmpty)
                            Row(
                              key: const ValueKey("dsAuthTemplateDividerRow"),
                              children: [
                                Expanded(
                                  child: Divider(
                                    key: const ValueKey(
                                      "dsAuthTemplateDividerLeft",
                                    ),
                                    color: textColor.withValues(alpha: 0.3),
                                    thickness: 0.8,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  child: Text(
                                    key: const ValueKey(
                                      "dsAuthTemplateDividerLabel",
                                    ),
                                    "o",
                                    style: DSTypographyFoundations.bodySmall
                                        .copyWith(color: textColor),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    key: const ValueKey(
                                      "dsAuthTemplateDividerRight",
                                    ),
                                    color: textColor.withValues(alpha: 0.3),
                                    thickness: 0.8,
                                  ),
                                ),
                              ],
                            ),
                          // Esopaciado
                          if (listSocialButtons.isNotEmpty)
                            const SizedBox(height: 16),
                          // Botones sociales
                          if (listSocialButtons.isNotEmpty)
                            Wrap(
                              key: const ValueKey("dsAuthTemplateSocialWrap"),
                              spacing: 12,
                              runSpacing: 8,
                              alignment: WrapAlignment.center,
                              children: listSocialButtons,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
