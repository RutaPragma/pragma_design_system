import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pragma_design_system/src/components/atoms/atoms.dart';
import 'package:pragma_design_system/src/foundations/foundations.dart';
import 'package:pragma_design_system/src/utils/enums.dart';

/// Molécula: DSOrderSummary
///
/// Muestra un resumen completo de una orden del e-commerce.
/// - Lista de productos resumidos
/// - Subtotal, envío y total
/// - Estado de la orden con DSBadge
/// - Botón de acción (por ejemplo, "Ver detalles" o "Rastrear pedido")
///
/// Ejemplo de uso:
/// ```dart
/// DSOrderSummary(
///   orderId: '12345',
///   orderDate: '2025-10-19',
///   orderStatus: 'Entregado',
///   products: [
///     {'imageUrl': '...', 'title': 'Producto 1', 'price': '29.900', 'quantity': 2},
///     {'imageUrl': '...', 'title': 'Producto 2', 'price': '15.000', 'quantity': 1},
///   ],
///   subtotal: '44.900',
///   shipping: '5.000',
///   total: '49.900',
///   actionLabel: 'Ver detalles',
///   onAction: () => print('Ver detalles'),
/// )
/// ```
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
      key: const ValueKey("dsOrderSummaryContainer"),
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
        key: const ValueKey("dsOrderSummaryPadding"),
        padding: EdgeInsets.all(DSSizesFoundations.separatorMedium),
        child: Column(
          key: const ValueKey("dsOrderSummaryColumn"),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado con ID y estado
            Row(
              key: const ValueKey("dsOrderSummaryHeaderRow"),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  key: const ValueKey("dsOrderSummaryTitle"),
                  "Orden #$orderId",
                  style: DSTypographyFoundations.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: effectiveTextColor,
                  ),
                ),
                DSBadge(
                  key: const ValueKey("dsOrderSummaryStatusBadge"),
                  label: orderStatus,
                  backgroundColor: _statusColor(orderStatus),
                  textColor: DSColorsFoundations.textOnPrimary,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              key: const ValueKey("dsOrderSummaryDate"),
              orderDate,
              style: DSTypographyFoundations.bodySmall.copyWith(
                color: DSColorsFoundations.textSecondary,
              ),
            ),
            const SizedBox(height: 12),

            // Lista de productos resumida
            ...products.asMap().entries.map((entry) {
              final p = entry.value;
              return Padding(
                key: ValueKey("dsOrderSummaryProductPadding_${entry.key}"),
                padding: EdgeInsets.only(
                  bottom: DSSizesFoundations.separatorSmall,
                ),
                child: Row(
                  key: ValueKey("dsOrderSummaryProductRow_${entry.key}"),
                  children: [
                    ClipRRect(
                      key: ValueKey("dsOrderSummaryProductImageClip_${entry.key}"),
                      borderRadius: BorderRadius.circular(
                        DSRadiusFoundations.radiusSM,
                      ),
                      child: Image.network(
                        key: ValueKey("dsOrderSummaryProductImage_${entry.key}"),
                        p['imageUrl'],
                        loadingBuilder:
                            (
                              BuildContext context,
                              Widget child,
                              ImageChunkEvent? loadingProgress,
                            ) {
                              if (loadingProgress == null) return child;
                              return const DSLoader(
                                key: ValueKey(
                                  "dsOrderSummaryProductImageLoader",
                                ),
                              );
                            },
                        width: 50,
                        height: 50,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        key: ValueKey("dsOrderSummaryProductTitle_${entry.key}"),
                        "${p['title']} (x${p['quantity']})",
                        style: DSTypographyFoundations.bodyMedium.copyWith(
                          color: effectiveTextColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      key: ValueKey("dsOrderSummaryProductPrice_${entry.key}"),
                      p['price'],
                      style: DSTypographyFoundations.bodyMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }),

            const Divider(
              key: ValueKey("dsOrderSummaryDivider"),
              height: 24,
            ),

            // Totales
            _buildPriceRow("Subtotal", subtotal, effectiveTextColor),
            _buildPriceRow("Envío", shipping, effectiveTextColor),
            const SizedBox(height: 6),
            _buildPriceRow("Total", total, effectiveTextColor, isBold: true),

            const SizedBox(height: 16),

            // Botón de acción
            if (onAction != null)
              DSButton(
                key: const ValueKey("dsOrderSummaryActionButton"),
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
        key: ValueKey("dsOrderSummaryPriceRow_$label"),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: DSTypographyFoundations.bodyMedium.copyWith(color: color),
          ),
          Text(
            '\$${NumberFormat("#,##0.00", "en_US").format(double.parse(value))}',
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
