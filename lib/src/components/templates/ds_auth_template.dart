import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/components/atoms/atoms.dart';
import 'package:pragma_design_system/src/components/organisms/organisms.dart';
import 'package:pragma_design_system/src/foundations/foundations.dart';
import 'package:pragma_design_system/src/utils/enums.dart';

/// Template de Autenticación (Login / Registro)
///
/// Combina los organismos:
/// - DSAuthForm (para iniciar sesión)
/// - DSRegisterUserForm (para crear una cuenta)
///
/// Se puede configurar completamente desde un Map.
/// También soporta imagen ilustrativa, logo y textos personalizados.
class DSAuthTemplate extends StatefulWidget {
  final Map<String, dynamic> config;

  const DSAuthTemplate({super.key, required this.config});

  @override
  State<DSAuthTemplate> createState() => _DSAuthTemplateState();
}

class _DSAuthTemplateState extends State<DSAuthTemplate> {
  bool _isLogin = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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
    final onLogin = widget.config["onLogin"];
    final onRegister = widget.config["onRegister"];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(
                        DSSizesFoundations.separatorLarge,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Logo opcional
                          if (logoUrl != null)
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 32,
                                top: 16,
                              ),
                              child: Image.asset(logoUrl, height: 80),
                            ),

                          Text(
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
                                    onSubmit: (login, password) =>
                                        onLogin?.call(login, password),
                                  )
                                : DSRegisterUserForm(
                                    key: const ValueKey("register"),
                                    config: registerConfig,
                                    onSubmit: (data) => onRegister?.call(data),
                                  ),
                          ),
                          const SizedBox(height: 24),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
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
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: textColor.withValues(alpha: 0.3),
                                  thickness: 0.8,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Text(
                                  "o",
                                  style: DSTypographyFoundations.bodySmall
                                      .copyWith(color: textColor),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: textColor.withValues(alpha: 0.3),
                                  thickness: 0.8,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Botones sociales
                          if (widget.config["socialButtons"] != null)
                            Wrap(
                              spacing: 12,
                              runSpacing: 8,
                              alignment: WrapAlignment.center,
                              children:
                                  (widget.config["socialButtons"]
                                          as List<Map<String, dynamic>>)
                                      .map(
                                        (btn) => DSButton(
                                          label: btn["label"],
                                          onPressed: btn["onPressed"],
                                          variant: DSButtonVariant.secondary,
                                          backgroundColor:
                                              btn["backgroundColor"] ?? bgColor,
                                          textColor:
                                              btn["textColor"] ?? textColor,
                                          icon: btn["icon"],
                                          isFullWidth: false,
                                        ),
                                      )
                                      .toList(),
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
