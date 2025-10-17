import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/components/atoms/atoms.dart';
import 'package:pragma_design_system/src/components/molecules/molecules.dart';
import 'package:pragma_design_system/src/foundations/foundations.dart';
import 'package:pragma_design_system/src/utils/enums.dart';

///Organismo: Formulario de dirección de envío configurable mediante [config].
///
/// Este widget permite definir etiquetas, placeholders, validaciones,
/// métodos de envío y colores personalizados directamente desde un `Map`.
///
/// Ejemplo:
/// ```dart
/// DSShippingForm(
///   config: {
///     "title": "Dirección de envío",
///     "fields": {
///       "name": {"label": "Nombre completo", "hint": "Ej. Juan Pérez", "required": true},
///       "address": {"label": "Dirección", "hint": "Ej. Calle 56 #84 - 33"},
///       "city": {"label": "Ciudad", "hint": "Ej. Cali"},
///       "zip": {"label": "Código postal", "hint": "Ej. 760001"},
///       "phone": {"label": "Teléfono", "hint": "+57 314 723 1734"},
///     },
///     "shippingMethods": [
///       {"label": "Estándar", "subtitle": "3-5 días hábiles"},
///       {"label": "Exprés", "subtitle": "1-2 días hábiles"},
///     ],
///     "submitLabel": "Guardar dirección",
///   },
///   onSubmit: (data) => print(data),
/// )
/// ```
class DSShippingForm extends StatefulWidget {
  final Map<String, dynamic> config;
  final void Function(Map<String, String> formData)? onSubmit;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? accentColor;
  final bool compact;

  const DSShippingForm({
    super.key,
    required this.config,
    this.onSubmit,
    this.backgroundColor,
    this.textColor,
    this.accentColor,
    this.compact = false,
  });

  @override
  State<DSShippingForm> createState() => _DSShippingFormState();
}

class _DSShippingFormState extends State<DSShippingForm> {
  final _formKey = GlobalKey<FormState>();
  final _controllers = <String, TextEditingController>{};
  String? _selectedShippingMethod;
  String isSelectShipping = '';
  int selectShippingIndex = 0;

  @override
  void initState() {
    super.initState();
    final fields = widget.config["fields"] ?? {};
    for (var key in fields.keys) {
      _controllers[key] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (var c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      final formData = {
        for (var e in _controllers.entries) e.key: e.value.text.trim(),
        "shippingMethod": _selectedShippingMethod ?? "",
      };
      widget.onSubmit?.call(formData);
    }
  }

  String _getFieldLabel(String key) =>
      widget.config["fields"]?[key]?["label"] ?? key;

  String _getFieldHint(String key) =>
      widget.config["fields"]?[key]?["hint"] ?? "";

  bool _isFieldRequired(String key) =>
      widget.config["fields"]?[key]?["required"] ?? true;

  String _getText(String key, [String fallback = ""]) =>
      widget.config[key]?.toString() ?? fallback;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg =
        widget.backgroundColor ??
        (isDark
            ? DSColorsFoundations.surfaceDark
            : DSColorsFoundations.surfaceLight);
    final text =
        widget.textColor ??
        (isDark
            ? DSColorsFoundations.textPrimaryDark
            : DSColorsFoundations.textPrimary);
    final accent =
        widget.accentColor ??
        (isDark
            ? DSColorsFoundations.brandPrimaryDark
            : DSColorsFoundations.brandPrimary);

    final shippingMethods = (widget.config["shippingMethods"] ?? []) as List;

    return Container(
      padding: EdgeInsets.all(
        widget.compact
            ? DSSizesFoundations.separatorMedium
            : DSSizesFoundations.separatorLarge,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(DSRadiusFoundations.radiusXL),
        boxShadow: DSShadowsFoundations.shadowMedium,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_getText("title").isNotEmpty)
              Text(
                _getText("title"),
                style: DSTypographyFoundations.displayMedium.copyWith(
                  color: text,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(height: 16),

            ///Se construye de forma dinamica el contenido del form, por eso es plano
            for (var key in _controllers.keys) ...[
              DSInputField(
                label: _getFieldLabel(key),
                hintText: _getFieldHint(key),
                controller: _controllers[key],
                validator: (v) {
                  if (_isFieldRequired(key) &&
                      (v == null || v.trim().isEmpty)) {
                    return "Campo obligatorio";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
            ],

            if (shippingMethods.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                _getText("shippingTitle", "Método de envío"),
                style: DSTypographyFoundations.labelMedium.copyWith(
                  color: text,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: DSSizesFoundations.separatorSmall,
                children: [
                  for (var method in shippingMethods)
                    _buildShippingOption(
                      method["label"] ?? "Opción",
                      method["subtitle"] ?? "",
                      accent,
                      selectShippingIndex,
                    ),
                ],
              ),
            ],

            const SizedBox(height: 24),
            DSButton(
              label: _getText("submitLabel", "Guardar dirección"),
              onPressed: _handleSubmit,
              backgroundColor: accent,
              textColor: isDark
                  ? DSColorsFoundations.textOnPrimaryDark
                  : DSColorsFoundations.textOnPrimary,
              variant: DSButtonVariant.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShippingOption(
    String title,
    String subtitle,
    Color accent,
    int index,
  ) {
    var isSelected = _selectedShippingMethod == title;

    if (isSelectShipping == '' && index == 0) {
      isSelected = true;
      _selectedShippingMethod = title;
    }
    selectShippingIndex++;
    return GestureDetector(
      onTap: () {
        isSelectShipping = '0';
        setState(() => _selectedShippingMethod = title);
      },
      child: DSChip(
        label: title,
        selected: isSelected,
        backgroundColor: isSelected
            ? accent.withValues(alpha: 0.15)
            : DSColorsFoundations.inputFill,
        textColor: isSelected ? accent : DSColorsFoundations.textSecondary,
      ),
    );
  }
}
