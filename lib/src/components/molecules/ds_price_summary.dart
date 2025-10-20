import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/components/atoms/atoms.dart';
import 'package:pragma_design_system/src/foundations/foundations.dart';
import 'package:pragma_design_system/src/utils/enums.dart';

/// Molécula: DSPriceSummary
///
/// Resumen de precios para carrito o checkout.
/// Muestra subtotal, envío, descuento y total, con un botón de acción.
/// Puede ser completamente parametrizable en colores y textos.
///
/// Ejemplo de uso:
/// ```dart
/// DSPriceSummary(
///   subtotal: 29900,
///   shipping: 5000,
///   discount: 2000,
///   total: 32900,
///   onButtonPressed: () => print('Continuar'),
/// )
/// ```
class DSPriceSummary extends StatelessWidget {
  final double subtotal;
  final double shipping;
  final double discount;
  final double total;
  final String subtotalLabel;
  final String shippingLabel;
  final String discountLabel;
  final String totalLabel;
  final String buttonLabel;
  final VoidCallback? onButtonPressed;
  final bool showBtnNest;

  // Personalización de colores
  final Color? backgroundColor;
  final Color? textColor;
  final Color? totalColor;
  final Color? dividerColor;

  const DSPriceSummary({
    super.key,
    required this.subtotal,
    required this.shipping,
    required this.discount,
    required this.total,
    this.subtotalLabel = "Subtotal",
    this.shippingLabel = "Envío",
    this.discountLabel = "Descuento",
    this.totalLabel = "Total",
    this.buttonLabel = "Continuar",
    this.onButtonPressed,
    this.backgroundColor,
    this.textColor,
    this.totalColor,
    this.dividerColor,
    this.showBtnNest = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor =
        backgroundColor ??
        (isDark
            ? DSColorsFoundations.surfaceDark
            : DSColorsFoundations.surfaceLight);

    final baseTextColor =
        textColor ??
        (isDark
            ? DSColorsFoundations.textPrimaryDark
            : DSColorsFoundations.textPrimary);

    final totalTextColor =
        totalColor ??
        (isDark
            ? DSColorsFoundations.brandSecondaryDark
            : DSColorsFoundations.brandSecondary);

    final dividerCol =
        dividerColor ??
        (isDark
            ? DSColorsFoundations.textHintDark.withValues(alpha: 0.2)
            : DSColorsFoundations.textHint.withValues(alpha: 0.2));

    return Card(
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(DSRadiusFoundations.radiusMD),
          boxShadow: DSShadowsFoundations.shadowSmall,
        ),
        padding: EdgeInsets.all(DSSpacingFoundations.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRow(subtotalLabel, subtotal, baseTextColor),
            SizedBox(height: DSSpacingFoundations.xs),
            _buildRow(shippingLabel, shipping, baseTextColor),
            if (discount > 0) ...[
              SizedBox(height: DSSpacingFoundations.xs),
              _buildRow(discountLabel, -discount, baseTextColor),
            ],
            Divider(color: dividerCol, height: DSSpacingFoundations.medium),
            _buildRow(
              totalLabel,
              total,
              totalTextColor,
              isBold: true,
              fontSize: DSSizesFoundations.textSizeLarge,
            ),
            SizedBox(height: DSSpacingFoundations.medium),
            if (showBtnNest)
              DSButton(
                label: buttonLabel,
                onPressed: onButtonPressed,
                variant: DSButtonVariant.primary,
                size: DSSize.medium,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(
    String label,
    double value,
    Color color, {
    bool isBold = false,
    double? fontSize,
  }) {
    final textStyle =
        (isBold
                ? DSTypographyFoundations.bodyLarge
                : DSTypographyFoundations.bodyMedium)
            .copyWith(
              color: color,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: fontSize,
            );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: textStyle),
        Text(_formatPrice(value), style: textStyle),
      ],
    );
  }

  String _formatPrice(double value) {
    final formatted = value
        .toStringAsFixed(2)
        .replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ',');
    return (value < 0
        ? '- \$${formatted.replaceFirst('-', '')}'
        : '\$$formatted');
  }
}

class PriceSummary {
  final double subtotal;
  final double shipping;
  final double discount;
  final double total;
  final String subtotalLabel;
  final String shippingLabel;
  final String discountLabel;
  final String totalLabel;
  final String buttonLabel;
  final VoidCallback? onButtonPressed;
  final bool showBtnNest;

  // Personalización de colores
  final Color? backgroundColor;
  final Color? textColor;
  final Color? totalColor;
  final Color? dividerColor;

  const PriceSummary({
    required this.subtotal,
    required this.shipping,
    required this.discount,
    required this.total,
    this.subtotalLabel = "Subtotal",
    this.shippingLabel = "Envío",
    this.discountLabel = "Descuento",
    this.totalLabel = "Total",
    this.buttonLabel = "Continuar",
    this.onButtonPressed,
    this.backgroundColor,
    this.textColor,
    this.totalColor,
    this.dividerColor,
    this.showBtnNest = true,
  });
}

class PriceSummaryMapper {
  static List<PriceSummary> fromMapList(List<Map<String, dynamic>> data) {
    return data.map((map) => fromMap(map)).toList();
  }

  static PriceSummary fromMap(Map<String, dynamic> map) {
    return PriceSummary(
      subtotal: (map['subtotal'] ?? 0).toDouble(),
      shipping: (map['shipping'] ?? 0).toDouble(),
      discount: (map['discount'] ?? 0).toDouble(),
      total: (map['total'] ?? 0).toDouble(),
      subtotalLabel: map['subtotalLabel'] ?? "Subtotal",
      shippingLabel: map['shippingLabel'] ?? "Envío",
      discountLabel: map['discountLabel'] ?? "Descuento",
      totalLabel: map['totalLabel'] ?? "Total",
      buttonLabel: map['buttonLabel'] ?? "Continuar",
      onButtonPressed: null, // No se puede serializar una función
      backgroundColor: _parseColor(map['backgroundColor']),
      textColor: _parseColor(map['textColor']),
      totalColor: _parseColor(map['totalColor']),
      dividerColor: _parseColor(map['dividerColor']),
      showBtnNest: map['showBtnNest'] ?? true,
    );
  }

  /// Helper privado para convertir colores en formato #RRGGBB o #AARRGGBB
  static Color? _parseColor(dynamic colorValue) {
    if (colorValue == null) return null;
    if (colorValue is Color) return colorValue;
    if (colorValue is String) {
      final hex = colorValue.replaceAll('#', '');
      if (hex.length == 6) {
        return Color(int.parse('FF$hex', radix: 16));
      } else if (hex.length == 8) {
        return Color(int.parse(hex, radix: 16));
      }
    }
    return null;
  }
}
