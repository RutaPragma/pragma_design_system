import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/components/atoms/atoms.dart';
import 'package:pragma_design_system/src/foundations/foundations.dart';
import 'package:pragma_design_system/src/utils/enums.dart';

/// Organismo: DSOrderSummary
///
/// Muestra un resumen completo de una orden del e-commerce.
/// - Lista de productos resumidos
/// - Subtotal, envío y total
/// - Estado de la orden con DSBadge
/// - Botón de acción (por ejemplo, "Ver detalles" o "Rastrear pedido")
class DSOrderSummary extends StatelessWidget {
  final String orderId;
  final String orderDate;
  final String orderStatus;
  final List<Map<String, dynamic>>
  products; // {imageUrl, title, price, quantity}
  final String subtotal;
  final String shipping;
  final String total;
  final String actionLabel;
  final VoidCallback? onAction;
  final Color? bgColor;
  final Color? textColor;
  final bool showShadow;

  const DSOrderSummary({
    super.key,
    required this.orderId,
    required this.orderDate,
    required this.orderStatus,
    required this.products,
    required this.subtotal,
    required this.shipping,
    required this.total,
    required this.actionLabel,
    this.onAction,
    this.bgColor,
    this.textColor,
    this.showShadow = true,
  });

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'entregado':
      case 'completado':
        return DSColorsFoundations.success;
      case 'pendiente':
      case 'procesando':
        return DSColorsFoundations.warning;
      case 'cancelado':
        return DSColorsFoundations.error;
      default:
        return DSColorsFoundations.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final effectiveBg =
        bgColor ??
        (isDark
            ? DSColorsFoundations.surfaceDark
            : DSColorsFoundations.surfaceLight);
    final effectiveTextColor =
        textColor ??
        (isDark
            ? DSColorsFoundations.textPrimaryDark
            : DSColorsFoundations.textPrimary);

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: DSSizesFoundations.separatorMedium,
        horizontal: DSSizesFoundations.separatorSmall,
      ),
      decoration: BoxDecoration(
        color: effectiveBg,
        borderRadius: BorderRadius.circular(DSRadiusFoundations.radiusMD),
        boxShadow: showShadow ? DSShadowsFoundations.shadowMedium : const [],
      ),
      child: Padding(
        padding: EdgeInsets.all(DSSizesFoundations.separatorMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado con ID y estado
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Orden #$orderId",
                  style: DSTypographyFoundations.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: effectiveTextColor,
                  ),
                ),
                DSBadge(
                  label: orderStatus,
                  backgroundColor: _statusColor(orderStatus),
                  textColor: DSColorsFoundations.textOnPrimary,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              orderDate,
              style: DSTypographyFoundations.bodySmall.copyWith(
                color: DSColorsFoundations.textSecondary,
              ),
            ),
            const SizedBox(height: 12),

            // Lista de productos resumida
            ...products.map((p) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: DSSizesFoundations.separatorSmall,
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        DSRadiusFoundations.radiusSM,
                      ),
                      child: Image.network(
                        p['imageUrl'],
                        loadingBuilder:
                            (
                              BuildContext context,
                              Widget child,
                              ImageChunkEvent? loadingProgress,
                            ) {
                              if (loadingProgress == null) return child;
                              return DSLoader();
                            },
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "${p['title']} (x${p['quantity']})",
                        style: DSTypographyFoundations.bodyMedium.copyWith(
                          color: effectiveTextColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      p['price'],
                      style: DSTypographyFoundations.bodyMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }),

            const Divider(height: 24),

            // Totales
            _buildPriceRow("Subtotal", subtotal, effectiveTextColor),
            _buildPriceRow("Envío", shipping, effectiveTextColor),
            const SizedBox(height: 6),
            _buildPriceRow("Total", total, effectiveTextColor, isBold: true),

            const SizedBox(height: 16),

            // Botón de acción
            if (onAction != null)
              DSButton(
                label: actionLabel,
                onPressed: onAction,
                variant: DSButtonVariant.primary,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(
    String label,
    String value,
    Color color, {
    bool isBold = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: DSTypographyFoundations.bodyMedium.copyWith(color: color),
          ),
          Text(
            value,
            style: DSTypographyFoundations.bodyMedium.copyWith(
              color: color,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class OrderSummaryModel {
  final String orderId;
  final String orderDate;
  final String orderStatus;
  final List<Map<String, dynamic>>
  products; // {imageUrl, title, price, quantity}
  final String subtotal;
  final String shipping;
  final String total;
  final String actionLabel;
  final Color? bgColor;
  final Color? textColor;
  final bool showShadow;

  const OrderSummaryModel({
    required this.orderId,
    required this.orderDate,
    required this.orderStatus,
    required this.products,
    required this.subtotal,
    required this.shipping,
    required this.total,
    required this.actionLabel,
    this.bgColor,
    this.textColor,
    this.showShadow = true,
  });
}

class DSOrderSummaryMapper {
  /// Convierte un solo Map en un modelo DSOrderSummary
  static OrderSummaryModel fromMap(Map<String, dynamic> map) {
    return OrderSummaryModel(
      orderId: map['orderId'] ?? '',
      orderDate: map['orderDate'] ?? '',
      orderStatus: map['orderStatus'] ?? '',
      products: List<Map<String, dynamic>>.from(map['products'] ?? []),
      subtotal: map['subtotal'] ?? '',
      shipping: map['shipping'] ?? '',
      total: map['total'] ?? '',
      actionLabel: map['actionLabel'] ?? '',
      bgColor: _parseColor(map['bgColor']),
      textColor: _parseColor(map['textColor']),
      showShadow: map['showShadow'] ?? true,
    );
  }

  /// Helper privado para convertir un color en formato hexadecimal (#RRGGBB o #AARRGGBB)
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
