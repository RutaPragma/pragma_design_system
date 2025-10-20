import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/components/atoms/atoms.dart';
import 'package:pragma_design_system/src/foundations/foundations.dart';
import 'package:pragma_design_system/src/components/molecules/ds_icon_counter.dart';
import 'package:pragma_design_system/src/components/molecules/ds_price_summary.dart';
import 'package:pragma_design_system/src/utils/enums.dart';

/// Organismo: DSCartPreview
///
/// Vista previa del carrito de compras.
/// Combina varios átomos y moléculas:
/// - DSIconCounter (cantidad de productos)
/// - DSPriceSummary (subtotal, envío, total)
/// - DSButton (acción principal)
///
/// Ideal para mostrarse en pantallas de checkout o popups flotantes.
///
/// Ejemplo de uso:
/// ```dart
/// DSCartPreview(
///   itemCount: 3,
///   subtotal: 29900,
///   shipping: 5000,
///   total: 34900,
///   onCheckout: () => print('Finalizar compra'),
///   onViewCart: () => print('Ver carrito'),
/// )
/// ```
class DSCartPreview extends StatelessWidget {
  final int itemCount;
  final double subtotal;
  final double shipping;
  final double total;
  final VoidCallback? onCheckout;
  final VoidCallback? onViewCart;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? accentColor;
  final String? checkoutLabel;
  final String? viewCartLabel;
  final bool showShipping;
  final bool showDivider;
  final bool compact;
  final bool showBtnNest;

  const DSCartPreview({
    super.key,
    required this.itemCount,
    required this.subtotal,
    required this.total,
    this.shipping = 0,
    this.onCheckout,
    this.onViewCart,
    this.backgroundColor,
    this.textColor,
    this.accentColor,
    this.checkoutLabel = "Finalizar compra",
    this.viewCartLabel = "Ver carrito",
    this.showShipping = true,
    this.showDivider = true,
    this.compact = false,
    this.showBtnNest = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bg =
        backgroundColor ??
        (isDark
            ? DSColorsFoundations.surfaceDark
            : DSColorsFoundations.surfaceLight);

    final text =
        textColor ??
        (isDark
            ? DSColorsFoundations.textPrimaryDark
            : DSColorsFoundations.textPrimary);

    final accent =
        accentColor ??
        (isDark
            ? DSColorsFoundations.brandPrimaryDark
            : DSColorsFoundations.brandPrimary);

    return Container(
      padding: EdgeInsets.all(DSSizesFoundations.separatorLarge),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(DSRadiusFoundations.radiusXL),
        boxShadow: DSShadowsFoundations.shadowMedium,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: compact ? MainAxisSize.min : MainAxisSize.max,
        children: [
          // Encabezado con ícono de carrito + contador
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.shopping_cart_rounded,
                    color: accent,
                    size: DSSizesFoundations.iconSizeLarge,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Tu carrito",
                    style: DSTypographyFoundations.displayMedium.copyWith(
                      color: text,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              DSIconCounter(
                icon: Icons.shopping_bag_rounded,
                iconColor: isDark
                    ? DSColorsFoundations.textSecondaryDark
                    : DSColorsFoundations.brandSecondaryDark,
                count: itemCount,
              ),
            ],
          ),

          if (showDivider) ...[
            const SizedBox(height: 12),
            Divider(
              thickness: 1,
              color: isDark
                  ? DSColorsFoundations.surfaceLight.withValues(alpha: 0.1)
                  : DSColorsFoundations.surfaceDark.withValues(alpha: 0.1),
            ),
          ],

          // Resumen de precios
          const SizedBox(height: 8),
          DSPriceSummary(
            subtotal: subtotal,
            shipping: showShipping ? shipping : 0,
            total: total,
            totalColor: isDark
                ? DSColorsFoundations.textSecondaryDark
                : DSColorsFoundations.brandSecondaryDark,
            textColor: text,
            showBtnNest: showBtnNest,
            discount: 1.12,
          ),

          const SizedBox(height: 16),

          // Acciones principales
          Column(
            children: [
              if (onCheckout != null)
                DSButton(
                  label: checkoutLabel ?? "Finalizar compra",
                  onPressed: onCheckout,
                  variant: DSButtonVariant.primary,
                  backgroundColor: accent,
                ),
              if (onViewCart != null) ...[
                const SizedBox(height: 8),
                DSButton(
                  label: viewCartLabel ?? "Ver carrito",
                  onPressed: onViewCart,
                  variant: DSButtonVariant.secondary,
                  backgroundColor: bg,
                  textColor: isDark
                      ? DSColorsFoundations.textSecondaryDark
                      : DSColorsFoundations.brandSecondary,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
