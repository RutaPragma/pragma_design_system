import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/components/atoms/atoms.dart';
import 'package:pragma_design_system/src/components/molecules/molecules.dart';
import 'package:pragma_design_system/src/foundations/foundations.dart';
import 'package:pragma_design_system/src/utils/enums.dart';

/// Organismo: Formulario de dirección de envío.
///
/// Usa átomos del sistema:
/// - DSInputField para campos de texto
/// - DSButton para acción principal
/// - DSChip opcional para selección de métodos de envío
///
/// Permite validaciones, estilos personalizados y modo oscuro adaptativo.
class DSShippingForm extends StatefulWidget {
  final void Function(Map<String, String> formData)? onSubmit;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? accentColor;
  final String? submitLabel;
  final bool compact;

  const DSShippingForm({
    super.key,
    this.onSubmit,
    this.backgroundColor,
    this.textColor,
    this.accentColor,
    this.submitLabel,
    this.compact = false,
  });

  @override
  State<DSShippingForm> createState() => _DSShippingFormState();
}

class _DSShippingFormState extends State<DSShippingForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipController = TextEditingController();
  final _phoneController = TextEditingController();

  String? _selectedShippingMethod;

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _zipController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSubmit?.call({
        "name": _nameController.text.trim(),
        "address": _addressController.text.trim(),
        "city": _cityController.text.trim(),
        "zip": _zipController.text.trim(),
        "phone": _phoneController.text.trim(),
        "shippingMethod": _selectedShippingMethod ?? "",
      });
    }
  }

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
            Text(
              "Dirección de envío",
              style: DSTypographyFoundations.displayMedium.copyWith(
                color: text,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            DSInputField(
              label: "Nombre completo",
              hintText: "Ej. Juan Pérez",
              controller: _nameController,
              validator: (v) =>
                  v == null || v.isEmpty ? "Campo obligatorio" : null,
            ),
            const SizedBox(height: 12),

            DSInputField(
              label: "Dirección",
              hintText: "Ej. Calle 56 #84 - 33",
              controller: _addressController,
              validator: (v) =>
                  v == null || v.isEmpty ? "Campo obligatorio" : null,
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: DSInputField(
                    label: "Ciudad",
                    hintText: "Ej. Cali",
                    controller: _cityController,
                    validator: (v) =>
                        v == null || v.isEmpty ? "Campo obligatorio" : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DSInputField(
                    label: "Código postal",
                    hintText: "Ej. 760001",
                    controller: _zipController,
                    keyboardType: TextInputType.number,
                    validator: (v) =>
                        v == null || v.isEmpty ? "Campo obligatorio" : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            DSInputField(
              label: "Teléfono",
              hintText: "+57 314 723 1734",
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              validator: (v) =>
                  v == null || v.isEmpty ? "Campo obligatorio" : null,
            ),
            const SizedBox(height: 16),

            Text(
              "Método de envío",
              style: DSTypographyFoundations.labelMedium.copyWith(
                color: text,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),

            Wrap(
              spacing: DSSizesFoundations.separatorSmall,
              children: [
                _buildShippingOption("Estándar", "3-5 días hábiles", accent),
                _buildShippingOption("Exprés", "1-2 días hábiles", accent),
              ],
            ),

            const SizedBox(height: 24),
            DSButton(
              label: widget.submitLabel ?? "Guardar dirección",
              onPressed: _handleSubmit,
              backgroundColor: accent,
              textColor: DSColorsFoundations.textOnPrimary,
              variant: DSButtonVariant.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShippingOption(String title, String subtitle, Color accent) {
    final isSelected = _selectedShippingMethod == title;
    return GestureDetector(
      onTap: () => setState(() => _selectedShippingMethod = title),
      child: DSChip(
        label: title,
        // subtitle: subtitle,
        backgroundColor: isSelected
            ? accent.withValues(alpha: 0.15)
            : DSColorsFoundations.inputFill,
        textColor: isSelected ? accent : DSColorsFoundations.textSecondary,
        // showCheck: isSelected,
      ),
    );
  }
}
