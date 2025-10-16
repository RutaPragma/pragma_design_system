import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/components/atoms/atoms.dart';
import 'package:pragma_design_system/src/foundations/foundations.dart';
import 'package:pragma_design_system/src/utils/enums.dart';

/// Molécula: resumen de precios para carrito o checkout.
///
/// Muestra subtotal, envío, descuento y total, con un botón de acción.
/// Puede ser completamente parametrizable en colores y textos.
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

    return Container(
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
          DSButton(
            label: buttonLabel,
            onPressed: onButtonPressed,
            variant: DSButtonVariant.primary,
            size: DSSize.medium,
          ),
        ],
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
